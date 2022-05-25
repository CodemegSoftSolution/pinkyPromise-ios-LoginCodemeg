//
//  MessageLikeResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 17/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct MessageLikeResponse: Codable {
    let status: Int
    let message: String
    let data: LikeModel?

    enum CodingKeys: String, CodingKey {
        case status, message
        case data = "Data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        data = try values.decodeIfPresent(LikeModel.self, forKey: .data) ?? nil
    }
    
}

// MARK: - DataClass
struct LikeModel: Codable {
    var id, userFlag: Int
    let userID, AuthorID: String
    var like, unlike, rewardFlag, CoinsEarned: Int

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case userFlag = "UserFlag"
        case userID = "UserID"
        case like = "Like"
        case unlike = "Unlike"
        case rewardFlag, CoinsEarned, AuthorID
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        like = try values.decodeIfPresent(Int.self, forKey: .like) ?? DocumentDefaultValues.Empty.int
        unlike = try values.decodeIfPresent(Int.self, forKey: .unlike) ?? DocumentDefaultValues.Empty.int
        userFlag = try values.decodeIfPresent(Int.self, forKey: .userFlag) ?? DocumentDefaultValues.Empty.int
        userID = try values.decodeIfPresent(String.self, forKey: .userID) ?? DocumentDefaultValues.Empty.string
        
        rewardFlag = try values.decodeIfPresent(Int.self, forKey: .rewardFlag) ?? DocumentDefaultValues.Empty.int
        CoinsEarned = try values.decodeIfPresent(Int.self, forKey: .CoinsEarned) ?? DocumentDefaultValues.Empty.int
        AuthorID = try values.decodeIfPresent(String.self, forKey: .AuthorID) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        id = DocumentDefaultValues.Empty.int
        like = DocumentDefaultValues.Empty.int
        unlike = DocumentDefaultValues.Empty.int
        userFlag = DocumentDefaultValues.Empty.int
        userID = DocumentDefaultValues.Empty.string
        
        rewardFlag = DocumentDefaultValues.Empty.int
        CoinsEarned = DocumentDefaultValues.Empty.int
        AuthorID = DocumentDefaultValues.Empty.string
    }
    
}




// MARK: - Welcome
struct CountResponse: Codable {
    let status: Int
    let message: String
    let unreadMsgCount: Int

    enum CodingKeys: String, CodingKey {
        case status, message
        case unreadMsgCount = "UnreadMsgCount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        unreadMsgCount = try values.decodeIfPresent(Int.self, forKey: .unreadMsgCount) ?? DocumentDefaultValues.Empty.int
    }
    
}
