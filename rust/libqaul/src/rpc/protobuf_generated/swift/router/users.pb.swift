// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: router/users.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// how is the user connected
enum Qaul_Rpc_Users_Connectivity: SwiftProtobuf.Enum {
  typealias RawValue = Int

  /// The user is actively connected to the node
  /// and reachable for synchronous communication.
  case online // = 0

  /// The node which hosts the user account is online 
  /// but the user is not actively connected to it.
  /// Messages can sent and will reach the node.
  case reachable // = 1

  /// The user is currently not reachable.
  case offline // = 2
  case UNRECOGNIZED(Int)

  init() {
    self = .online
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .online
    case 1: self = .reachable
    case 2: self = .offline
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .online: return 0
    case .reachable: return 1
    case .offline: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Qaul_Rpc_Users_Connectivity: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Qaul_Rpc_Users_Connectivity] = [
    .online,
    .reachable,
    .offline,
  ]
}

#endif  // swift(>=4.2)

/// users rpc message container
struct Qaul_Rpc_Users_Users {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var message: Qaul_Rpc_Users_Users.OneOf_Message? = nil

  var userRequest: Qaul_Rpc_Users_UserRequest {
    get {
      if case .userRequest(let v)? = message {return v}
      return Qaul_Rpc_Users_UserRequest()
    }
    set {message = .userRequest(newValue)}
  }

  var userList: Qaul_Rpc_Users_UserList {
    get {
      if case .userList(let v)? = message {return v}
      return Qaul_Rpc_Users_UserList()
    }
    set {message = .userList(newValue)}
  }

  var userUpdate: Qaul_Rpc_Users_UserEntry {
    get {
      if case .userUpdate(let v)? = message {return v}
      return Qaul_Rpc_Users_UserEntry()
    }
    set {message = .userUpdate(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Message: Equatable {
    case userRequest(Qaul_Rpc_Users_UserRequest)
    case userList(Qaul_Rpc_Users_UserList)
    case userUpdate(Qaul_Rpc_Users_UserEntry)

  #if !swift(>=4.1)
    static func ==(lhs: Qaul_Rpc_Users_Users.OneOf_Message, rhs: Qaul_Rpc_Users_Users.OneOf_Message) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.userRequest, .userRequest): return {
        guard case .userRequest(let l) = lhs, case .userRequest(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.userList, .userList): return {
        guard case .userList(let l) = lhs, case .userList(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.userUpdate, .userUpdate): return {
        guard case .userUpdate(let l) = lhs, case .userUpdate(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  init() {}
}

/// UI request for some users
struct Qaul_Rpc_Users_UserRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// user list
struct Qaul_Rpc_Users_UserList {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var user: [Qaul_Rpc_Users_UserEntry] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// user entry
struct Qaul_Rpc_Users_UserEntry {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var name: String = String()

  var id: Data = Data()

  var idBase58: String = String()

  /// protobuf encoded public key
  var key: Data = Data()

  var keyType: String = String()

  var keyBase58: String = String()

  var connectivity: Qaul_Rpc_Users_Connectivity = .online

  var verified: Bool = false

  var blocked: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "qaul.rpc.users"

extension Qaul_Rpc_Users_Connectivity: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "Online"),
    1: .same(proto: "Reachable"),
    2: .same(proto: "Offline"),
  ]
}

extension Qaul_Rpc_Users_Users: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Users"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "user_request"),
    2: .standard(proto: "user_list"),
    3: .standard(proto: "user_update"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try {
        var v: Qaul_Rpc_Users_UserRequest?
        var hadOneofValue = false
        if let current = self.message {
          hadOneofValue = true
          if case .userRequest(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.message = .userRequest(v)
        }
      }()
      case 2: try {
        var v: Qaul_Rpc_Users_UserList?
        var hadOneofValue = false
        if let current = self.message {
          hadOneofValue = true
          if case .userList(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.message = .userList(v)
        }
      }()
      case 3: try {
        var v: Qaul_Rpc_Users_UserEntry?
        var hadOneofValue = false
        if let current = self.message {
          hadOneofValue = true
          if case .userUpdate(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.message = .userUpdate(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    switch self.message {
    case .userRequest?: try {
      guard case .userRequest(let v)? = self.message else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }()
    case .userList?: try {
      guard case .userList(let v)? = self.message else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }()
    case .userUpdate?: try {
      guard case .userUpdate(let v)? = self.message else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Qaul_Rpc_Users_Users, rhs: Qaul_Rpc_Users_Users) -> Bool {
    if lhs.message != rhs.message {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Qaul_Rpc_Users_UserRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".UserRequest"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Qaul_Rpc_Users_UserRequest, rhs: Qaul_Rpc_Users_UserRequest) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Qaul_Rpc_Users_UserList: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".UserList"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "user"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.user) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.user.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.user, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Qaul_Rpc_Users_UserList, rhs: Qaul_Rpc_Users_UserList) -> Bool {
    if lhs.user != rhs.user {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Qaul_Rpc_Users_UserEntry: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".UserEntry"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
    2: .same(proto: "id"),
    4: .standard(proto: "id_base58"),
    5: .same(proto: "key"),
    6: .standard(proto: "key_type"),
    7: .standard(proto: "key_base58"),
    8: .same(proto: "connectivity"),
    9: .same(proto: "verified"),
    10: .same(proto: "blocked"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self.id) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.idBase58) }()
      case 5: try { try decoder.decodeSingularBytesField(value: &self.key) }()
      case 6: try { try decoder.decodeSingularStringField(value: &self.keyType) }()
      case 7: try { try decoder.decodeSingularStringField(value: &self.keyBase58) }()
      case 8: try { try decoder.decodeSingularEnumField(value: &self.connectivity) }()
      case 9: try { try decoder.decodeSingularBoolField(value: &self.verified) }()
      case 10: try { try decoder.decodeSingularBoolField(value: &self.blocked) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if !self.id.isEmpty {
      try visitor.visitSingularBytesField(value: self.id, fieldNumber: 2)
    }
    if !self.idBase58.isEmpty {
      try visitor.visitSingularStringField(value: self.idBase58, fieldNumber: 4)
    }
    if !self.key.isEmpty {
      try visitor.visitSingularBytesField(value: self.key, fieldNumber: 5)
    }
    if !self.keyType.isEmpty {
      try visitor.visitSingularStringField(value: self.keyType, fieldNumber: 6)
    }
    if !self.keyBase58.isEmpty {
      try visitor.visitSingularStringField(value: self.keyBase58, fieldNumber: 7)
    }
    if self.connectivity != .online {
      try visitor.visitSingularEnumField(value: self.connectivity, fieldNumber: 8)
    }
    if self.verified != false {
      try visitor.visitSingularBoolField(value: self.verified, fieldNumber: 9)
    }
    if self.blocked != false {
      try visitor.visitSingularBoolField(value: self.blocked, fieldNumber: 10)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Qaul_Rpc_Users_UserEntry, rhs: Qaul_Rpc_Users_UserEntry) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.id != rhs.id {return false}
    if lhs.idBase58 != rhs.idBase58 {return false}
    if lhs.key != rhs.key {return false}
    if lhs.keyType != rhs.keyType {return false}
    if lhs.keyBase58 != rhs.keyBase58 {return false}
    if lhs.connectivity != rhs.connectivity {return false}
    if lhs.verified != rhs.verified {return false}
    if lhs.blocked != rhs.blocked {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}