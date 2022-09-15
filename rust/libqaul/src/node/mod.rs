// Copyright (c) 2021 Open Community Project Association https://ocpa.ch
// This software is published under the AGPLv3 license.

//! # Node Module
//!
//! Creates a node on first startup.
//! Loads the node definition from configuration and keeps it in
//! local state.
//! Provides state information of the local node to libqaul.

pub mod user_accounts;

use base64;
use libp2p::{
    floodsub::Topic,
    identity::{ed25519, Keypair},
    PeerId,
};
use log::{error, info};
use prost::Message;
use state;

use crate::connections::{internet::Internet, lan::Lan};
use crate::rpc::Rpc;
use crate::storage::configuration::Configuration;
use crate::utilities::qaul_id::QaulId;
use user_accounts::UserAccounts;

/// central state of this instances Node struct
static NODE: state::Storage<Node> = state::Storage::new();

/// Import protobuf message definition generated by
/// the rust module prost-build.
pub mod proto {
    include!("qaul.rpc.node.rs");
}

/// This Node
pub struct Node {
    id: PeerId,
    keys: Keypair,
    topic: Topic,
}

impl Node {
    /// start an existing node from the config parameters
    pub fn init() {
        // initialize users of this node
        UserAccounts::init();

        // initialize node
        {
            if !Configuration::is_node_initialized() {
                // create a new node and save it to configuration
                info!("Create a new node.");
                Self::new();

                // check if qauld is running
                #[cfg(feature = "defaultaccount")]
                log::info!("feature defaultaccount is on: qauld is running, create user account");
                #[cfg(not(feature = "defaultaccount"))]
                log::info!("feature defaultaccount is off");
            } else {
                // instantiate node from configuration
                info!("Setup node from configuration.");
                Self::from_config();
            }
        }
    }

    /// create a new node and save the parameters into config
    fn new() {
        // create node
        let keys_ed25519 = ed25519::Keypair::generate();
        let keys = Keypair::Ed25519(keys_ed25519.clone());
        let id = PeerId::from(keys.public());
        let topic = Topic::new("pages");
        let node = Node { id, keys, topic };

        // save node to configuration file
        {
            let mut config = Configuration::get_mut();
            config.node.keys = base64::encode(keys_ed25519.encode());
            config.node.id = id.to_string();
            config.node.initialized = 1;
        }
        Configuration::save();

        // display id
        info!("Peer Id: {}", node.id.clone());

        // save node to state
        NODE.set(node);
    }

    /// start an existing node from the config parameters
    fn from_config() {
        let config = Configuration::get();
        let mut basedecode = base64::decode(&config.node.keys).unwrap();
        let keys = Keypair::Ed25519(ed25519::Keypair::decode(&mut basedecode).unwrap());
        let id = PeerId::from(keys.public());
        let topic = Topic::new("pages");

        // check if saved ID and the id from the keypair are equal
        if id.to_string() == config.node.id {
            info!("id's match {}", config.node.id);
        } else {
            error!("------------------------------------");
            error!("ERROR: id's are not equal");
            error!("{}  {}", id.to_string(), config.node.id);
            error!("------------------------------------");
        }

        let node = Node { id, keys, topic };
        NODE.set(node);
    }

    /// get a cloned PeerId
    pub fn get_id() -> PeerId {
        let node = NODE.get();
        node.id.clone()
    }

    /// get small node ID
    pub fn get_small_id() -> Vec<u8> {
        let node = NODE.get();
        QaulId::to_small(node.id)
    }

    /// get the string of a PeerId
    pub fn get_id_string() -> String {
        let node = NODE.get();
        node.id.to_string()
    }

    /// Get the Keypair of this node
    pub fn get_keys<'a>() -> &'a Keypair {
        let node = NODE.get();
        &node.keys
    }

    /// get the cloned Topic
    pub fn get_topic() -> Topic {
        let node = NODE.get();
        node.topic.clone()
    }

    /// Process incoming RPC request messages for node module
    pub fn rpc(data: Vec<u8>, lan: Option<&mut Lan>, internet: Option<&mut Internet>) {
        match proto::Node::decode(&data[..]) {
            Ok(node) => {
                match node.message {
                    Some(proto::node::Message::GetNodeInfo(_)) => {
                        Rpc::increase_message_counter();

                        // create address list
                        let mut addresses: Vec<String> = Vec::new();
                        if let Some(internet_connection) = internet {
                            // listener addresses
                            for address in internet_connection.swarm.listeners() {
                                addresses.push(address.to_string());
                            }
                            // external addresses
                            for address in internet_connection.swarm.external_addresses() {
                                addresses.push(address.addr.to_string());
                            }
                        } else if let Some(lan_connection) = lan {
                            // listener addresses
                            for address in lan_connection.swarm.listeners() {
                                addresses.push(address.to_string());
                            }
                            // external addresses
                            for address in lan_connection.swarm.external_addresses() {
                                addresses.push(address.addr.to_string());
                            }
                        } else {
                            log::error!("lan & internet swarms missing");
                        }

                        // create response message
                        let proto_nodeinformation = proto::NodeInformation {
                            id_base58: Self::get_id_string(),
                            addresses,
                        };

                        let proto_message = proto::Node {
                            message: Some(proto::node::Message::Info(proto_nodeinformation)),
                        };

                        // encode message
                        let mut buf = Vec::with_capacity(proto_message.encoded_len());
                        proto_message
                            .encode(&mut buf)
                            .expect("Vec<u8> provides capacity as needed");

                        // send message
                        Rpc::send_message(
                            buf,
                            crate::rpc::proto::Modules::Node.into(),
                            "".to_string(),
                            Vec::new(),
                        );
                    }
                    _ => {
                        log::error!("rpc message undefined");
                    }
                }
            }
            Err(error) => {
                log::error!("{:?}", error);
            }
        }
    }
}
