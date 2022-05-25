//
//  ChatRoomResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 10/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ChatRoomResponse: Codable {
    let status: Int
    let message: String
    let chatRooms: [ChatRoomModel]

    enum CodingKeys: String, CodingKey {
        case status, message
        case chatRooms = "ChatRooms"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        chatRooms = try values.decodeIfPresent([ChatRoomModel].self, forKey: .chatRooms) ?? []
    }
}

// MARK: - ChatRoom
struct ChatRoomModel: Codable {
    var purpleID: String
    let id: Int
    let name, chatRoomID, chatRoomDescription, avatar: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case purpleID = "_id"
        case id = "ID"
        case name = "Name"
        case chatRoomID = "ChatRoomID"
        case chatRoomDescription = "Description"
        case avatar = "Avatar"
        case icon = "Icon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        purpleID = try values.decodeIfPresent(String.self, forKey: .purpleID) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        purpleID = try values.decodeIfPresent(String.self, forKey: .purpleID) ?? DocumentDefaultValues.Empty.string
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DocumentDefaultValues.Empty.string
        icon = try values.decodeIfPresent(String.self, forKey: .icon) ?? DocumentDefaultValues.Empty.string
        chatRoomID = try values.decodeIfPresent(String.self, forKey: .chatRoomID) ?? DocumentDefaultValues.Empty.string
        chatRoomDescription = try values.decodeIfPresent(String.self, forKey: .chatRoomDescription) ?? DocumentDefaultValues.Empty.string
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        purpleID = DocumentDefaultValues.Empty.string
        id = DocumentDefaultValues.Empty.int
        purpleID = DocumentDefaultValues.Empty.string
        name = DocumentDefaultValues.Empty.string
        icon = DocumentDefaultValues.Empty.string
        chatRoomID = DocumentDefaultValues.Empty.string
        chatRoomDescription = DocumentDefaultValues.Empty.string
        avatar = DocumentDefaultValues.Empty.string
    }
    
}


