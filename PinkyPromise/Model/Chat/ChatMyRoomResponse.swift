//
//  ChatMyRoomResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 13/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ChatMyRoomResponse: Codable {
    let status: Int
    let message: String
    let chatRoomsInfo: [ChatMyRoomsInfoModel]

    enum CodingKeys: String, CodingKey {
        case status, message
        case chatRoomsInfo = "ChatRoomsInfo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        chatRoomsInfo = try values.decodeIfPresent([ChatMyRoomsInfoModel].self, forKey: .chatRoomsInfo) ?? []
    }
}

// MARK: - ChatRoomsInfo
struct ChatMyRoomsInfoModel: Codable {
    var lastSeenMessageID: Int
    var chatRoomName, avatar, latestMessage: String
    var latestMessageID, unreadCount: Int
    var latestMsgTimestamp: String
    var chatRoomID: String

    enum CodingKeys: String, CodingKey {
        case lastSeenMessageID = "LastSeenMessageID"
        case chatRoomName = "ChatRoomName"
        case avatar = "Avatar"
        case latestMessage = "LatestMessage"
        case latestMessageID = "LatestMessageID"
        case unreadCount = "UnreadCount"
        case latestMsgTimestamp = "LatestMsgTimestamp"
        case chatRoomID = "ChatRoomID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latestMessageID = try values.decodeIfPresent(Int.self, forKey: .latestMessageID) ?? DocumentDefaultValues.Empty.int
        unreadCount = try values.decodeIfPresent(Int.self, forKey: .unreadCount) ?? DocumentDefaultValues.Empty.int
        lastSeenMessageID = try values.decodeIfPresent(Int.self, forKey: .lastSeenMessageID) ?? DocumentDefaultValues.Empty.int
        chatRoomName = try values.decodeIfPresent(String.self, forKey: .chatRoomName) ?? DocumentDefaultValues.Empty.string
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar) ?? DocumentDefaultValues.Empty.string
        latestMessage = try values.decodeIfPresent(String.self, forKey: .latestMessage) ?? DocumentDefaultValues.Empty.string
        chatRoomID = try values.decodeIfPresent(String.self, forKey: .chatRoomID) ?? DocumentDefaultValues.Empty.string
        latestMsgTimestamp = try values.decodeIfPresent(String.self, forKey: .latestMsgTimestamp) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        latestMessageID = DocumentDefaultValues.Empty.int
        unreadCount = DocumentDefaultValues.Empty.int
        lastSeenMessageID = DocumentDefaultValues.Empty.int
        chatRoomName = DocumentDefaultValues.Empty.string
        avatar = DocumentDefaultValues.Empty.string
        latestMessage = DocumentDefaultValues.Empty.string
        chatRoomID = DocumentDefaultValues.Empty.string
        latestMsgTimestamp = DocumentDefaultValues.Empty.string
    }
    
}
