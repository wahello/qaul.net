// Copyright (c) 2021 Open Community Project Association https://ocpa.ch
// This software is published under the AGPLv3 license.

//! # Chat Text Message Handling
//!
//! The chat text messages are all chat messages, that can be sent,
//! in one single message.
//!
//! The sending of the files via the chat messaging is handled in the file.rs file.

use libp2p::PeerId;
use prost::Message;

use super::rpc_proto;
use super::{Chat, ChatStorage};
use crate::node::user_accounts::{UserAccount, UserAccounts};
use crate::services::group::{self, conversation_id::ConversationId};
use crate::services::messaging::{proto, Messaging, MessagingServiceType};
use crate::utilities::timestamp::Timestamp;

/// Incoming and outgoing chat message handling
pub struct ChatMessage {}

impl ChatMessage {
    /// send message
    pub fn send(
        user_account: &UserAccount,
        receiver: &PeerId,
        common_message: &proto::CommonMessage,
    ) -> Result<Vec<u8>, String> {
        let send_message = proto::Messaging {
            message: Some(proto::messaging::Message::CommonMessage(
                common_message.clone(),
            )),
        };
        Messaging::pack_and_send_message(
            user_account,
            &receiver,
            send_message.encode_to_vec(),
            MessagingServiceType::Chat,
            &common_message.message_id,
            true,
        )
    }

    /// send message
    pub fn send_chat_message(
        account_id: &PeerId,
        group_id: &Vec<u8>,
        message: String,
    ) -> Result<bool, String> {
        let conversation_id = ConversationId::from_bytes(&group_id).unwrap();
        let group;
        match group::GroupStorage::get_group(account_id.to_owned(), group_id.to_owned()) {
            Some(v) => group = v,
            None => {
                let error_string = "Group not found".to_string();
                // check if group is direct message
                match conversation_id.is_direct(account_id.to_owned()) {
                    // get user id from q8id
                    Some(user_q8id) => {
                        // create direct chat
                        match crate::router::users::Users::get_user_id_by_q8id(user_q8id) {
                            Some(user_id) => {
                                group = group::Manage::create_new_direct_chat_group(
                                    account_id, &user_id,
                                )
                            }
                            None => return Err(error_string),
                        }
                    }
                    None => return Err(error_string),
                }
            }
        }

        let mut my_member;
        match group.get_member(&account_id.to_bytes()) {
            Some(v) => {
                my_member = v.clone();
            }
            _ => {
                return Err("you are not member in this group".to_string());
            }
        }

        let last_index = my_member.last_message_index + 1;
        let timestamp = Timestamp::get_timestamp();
        let message_id = Chat::generate_message_id(&group.id, account_id, last_index);

        // pack message
        let common_message = proto::CommonMessage {
            message_id: message_id.clone(),
            conversation_id: conversation_id.to_bytes(),
            sent_at: timestamp,
            payload: Some(proto::common_message::Payload::ChatMessage(
                proto::ChatMessage {
                    content: message.clone(),
                },
            )),
        };

        // save outgoing message
        ChatStorage::save_outgoing_message(
            account_id,
            account_id,
            &conversation_id,
            &message_id,
            rpc_proto::ChatContentType::Chat.try_into().unwrap(),
            &message.encode_to_vec(),
            rpc_proto::MessageStatus::Sending,
        );

        // send to all group members
        if let Some(user_account) = UserAccounts::get_by_id(account_id.clone()) {
            for user_id in group.members.keys() {
                let receiver = PeerId::from_bytes(&user_id.clone()).unwrap();
                if receiver != *account_id {
                    log::error!("send message to {}", receiver.to_base58());
                    if let Err(error) = Self::send(&user_account, &receiver, &common_message) {
                        log::error!("chat message send error {}", error);
                    }
                }
            }
        }

        // update member state
        my_member.last_message_index = last_index;
        group::Group::update_group_member(account_id, group_id, &my_member);
        Ok(true)
    }
}