//
//  ChatRoomRequest.swift
//  PinkyPromise
//
//  Created by AkshCom on 12/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

// MARK: - SelectedOption
struct MyChatRoomRequest: Encodable {
    var userID: String
}

// MARK: - Welcome
struct UpdateUserChatRoomRequest: Encodable {
    var userID: String?
    var data: [UserChatRoomRequest]?
}

// MARK: - Datum
struct UserChatRoomRequest: Encodable {
    var infoID: Int?
    var chatRoomID, chatRoomName: String?
    var priority, latSeenMessageID: Int?
    var active: Bool?

    enum CodingKeys: String, CodingKey {
        case infoID = "InfoID"
        case chatRoomID = "ChatRoomID"
        case chatRoomName = "ChatRoomName"
        case priority = "Priority"
        case latSeenMessageID = "LatSeenMessageID"
        case active = "Active"
    }
}

struct MyChatMessageRequest: Codable {
    var UserID: String
    var ChatRoomId: String
    var LastMsgId: Int
}

struct ChatLikeUnlikeRequest: Codable {
    var UserID: String
    var ChatRoomId: String
    var MsgId: Int
    var Flag: String
}

struct UpdateChatRoomRequest: Codable {
    var userID: String
    var ChatRoomID: String
    var LastSeenMessageID: Int
//    var Flag: String
}

struct JoinChatRoomRequest: Encodable {
    var ChatRoom: String
//    var userInfo: userInfo?
    var userId: String
}

struct userInfo: Encodable {
    var userId: String
    var userName: String
}

struct SendMessageRequest: Codable {
    let chatRoomID: String
    let data: SendMessageData?

    enum CodingKeys: String, CodingKey {
        case chatRoomID = "ChatRoomId"
        case data
    }
}

struct SendMessageData: Codable {
    let id, userName, text: String?
    var replyID: Int?

    enum CodingKeys: String, CodingKey {
        case id, userName, text
        case replyID = "replyId"
    }
    
    init(id: String? = nil, userName: String? = nil, text: String? = nil, replyID: Int? = nil){
        self.id = id
        self.userName = userName
        self.replyID = replyID
        self.text = text
    }
}
