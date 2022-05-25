//
//  MessageListResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 17/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct MessageListResponse: Codable {
    let status: Int
    let message: String
    let data: [MessageListModel]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        data = try values.decodeIfPresent([MessageListModel].self, forKey: .data) ?? []
    }
    
}

// MARK: - Datum
struct MessageListModel: Codable {
    var id, like: Int
    var avatar: String
    var unlike: Int
    var datumID: String
    var colorCode: String?
    var timeStamp: String
    var replyMsgInfo: [MessageListModel]
    var type: String
//    let replyID: Int?
    var userID, text: String
    var userFlag: Int?
    var unlikeUsers, likeUsers: [String]
    
    var rewardFlag, CoinsEarned: Int

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case like = "Like"
        case avatar = "Avatar"
        case unlike = "Unlike"
        case datumID = "_id"
        case colorCode = "ColorCode"
        case timeStamp = "TimeStamp"
        case replyMsgInfo = "ReplyMsgInfo"
        case type = "Type"
//        case replyID = "ReplyID"
        case userID = "UserID"
        case text = "Text"
        case userFlag = "UserFlag"
        case unlikeUsers = "UnlikeUsers"
        case likeUsers = "LikeUsers"
        case rewardFlag, CoinsEarned
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        like = try values.decodeIfPresent(Int.self, forKey: .like) ?? DocumentDefaultValues.Empty.int
        unlike = try values.decodeIfPresent(Int.self, forKey: .unlike) ?? DocumentDefaultValues.Empty.int
//        replyID = try values.decodeIfPresent(Int.self, forKey: .replyID) ?? DocumentDefaultValues.Empty.int
        userFlag = try values.decodeIfPresent(Int.self, forKey: .userFlag) ?? DocumentDefaultValues.Empty.int
        datumID = try values.decodeIfPresent(String.self, forKey: .datumID) ?? DocumentDefaultValues.Empty.string
        colorCode = try values.decodeIfPresent(String.self, forKey: .colorCode) ?? DocumentDefaultValues.Empty.string
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? DocumentDefaultValues.Empty.string
        userID = try values.decodeIfPresent(String.self, forKey: .userID) ?? DocumentDefaultValues.Empty.string
        text = try values.decodeIfPresent(String.self, forKey: .text) ?? DocumentDefaultValues.Empty.string
        timeStamp = try values.decodeIfPresent(String.self, forKey: .timeStamp) ?? DocumentDefaultValues.Empty.string
        unlikeUsers = try values.decodeIfPresent([String].self, forKey: .unlikeUsers) ?? []
        likeUsers = try values.decodeIfPresent([String].self, forKey: .likeUsers) ?? []
        replyMsgInfo = try values.decodeIfPresent([MessageListModel].self, forKey: .replyMsgInfo) ?? []
        
        rewardFlag = try values.decodeIfPresent(Int.self, forKey: .rewardFlag) ?? DocumentDefaultValues.Empty.int
        CoinsEarned = try values.decodeIfPresent(Int.self, forKey: .CoinsEarned) ?? DocumentDefaultValues.Empty.int
    }
    
    init() {
        avatar = DocumentDefaultValues.Empty.string
        id = DocumentDefaultValues.Empty.int
        like = DocumentDefaultValues.Empty.int
        unlike = DocumentDefaultValues.Empty.int
//        replyID = DocumentDefaultValues.Empty.int
        userFlag = DocumentDefaultValues.Empty.int
        datumID = DocumentDefaultValues.Empty.string
        colorCode = DocumentDefaultValues.Empty.string
        type = DocumentDefaultValues.Empty.string
        userID = DocumentDefaultValues.Empty.string
        text = DocumentDefaultValues.Empty.string
        timeStamp = DocumentDefaultValues.Empty.string
        unlikeUsers = []
        likeUsers = []
        replyMsgInfo = []
        
        rewardFlag = DocumentDefaultValues.Empty.int
        CoinsEarned = DocumentDefaultValues.Empty.int
    }
    
}





