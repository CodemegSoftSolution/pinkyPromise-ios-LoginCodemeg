//
//  BedgesResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 21/01/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct TotalBedgesResponse: Codable {
    let message, ReferalCode: String
    let status: Int
    var TotalCoins: Int?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        TotalCoins = try values.decodeIfPresent(Int.self, forKey: .TotalCoins) ??  DocumentDefaultValues.Empty.int
        ReferalCode = try values.decodeIfPresent(String.self, forKey: .ReferalCode) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        status = DocumentDefaultValues.Empty.int
        message = DocumentDefaultValues.Empty.string
        TotalCoins = DocumentDefaultValues.Empty.int
        ReferalCode = DocumentDefaultValues.Empty.string
    }
}

struct WelcomeModel {
    var image, title, desc : String!
    
    init(_ dict : [String : Any]) {
        image = dict["image"] as? String ?? ""
        title = dict["title"] as? String ?? ""
        desc = dict["desc"] as? String ?? ""
    }
}

// MARK: - Welcome
struct RedeemBedgesResponse: Codable {
    let message: String
    let status: Int
    let data: RedeemModel?

    enum CodingKeys: String, CodingKey {
        case message, status
        case data = "Data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent(RedeemModel.self, forKey: .data) ?? nil
    }
}

// MARK: - DataClass
struct RedeemModel: Codable {
    let coins: Int
    let userID: String
    let coinsAmount: Int

    enum CodingKeys: String, CodingKey {
        case coins = "Coins"
        case userID = "UserID"
        case coinsAmount = "CoinsAmount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coins = try values.decodeIfPresent(Int.self, forKey: .coins) ?? DocumentDefaultValues.Empty.int
        userID = try values.decodeIfPresent(String.self, forKey: .userID) ?? DocumentDefaultValues.Empty.string
        coinsAmount = try values.decodeIfPresent(Int.self, forKey: .coinsAmount) ?? DocumentDefaultValues.Empty.int
    }
    
    init() {
        coins = DocumentDefaultValues.Empty.int
        userID = DocumentDefaultValues.Empty.string
        coinsAmount = DocumentDefaultValues.Empty.int
    }
}


// MARK: - Welcome
struct UserBedgesResponse: Codable {
    let message: String
    let status: Int
    let badges: [Badge]
    let data: [Badge]

    enum CodingKeys: String, CodingKey {
        case message, status
        case badges = "Badges"
        case data = "Data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        badges = try values.decodeIfPresent([Badge].self, forKey: .badges) ?? []
        data = try values.decodeIfPresent([Badge].self, forKey: .data) ?? []
    }
}

// MARK: - Badge
struct Badge: Codable {
    let userID, badge, id, rewardType: String
    let credited: String
    let avtive: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "UserID"
        case badge = "Badge"
        case id = "_id"
        case rewardType = "Reward_type"
        case credited = "Credited"
        case avtive = "Avtive"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        badge = try values.decodeIfPresent(String.self, forKey: .badge) ?? DocumentDefaultValues.Empty.string
        userID = try values.decodeIfPresent(String.self, forKey: .userID) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        rewardType = try values.decodeIfPresent(String.self, forKey: .rewardType) ?? DocumentDefaultValues.Empty.string
        credited = try values.decodeIfPresent(String.self, forKey: .credited) ?? DocumentDefaultValues.Empty.string
        avtive = try values.decodeIfPresent(Bool.self, forKey: .avtive) ?? DocumentDefaultValues.Empty.bool
    }
    
    init() {
        badge = DocumentDefaultValues.Empty.string
        userID = DocumentDefaultValues.Empty.string
        id = DocumentDefaultValues.Empty.string
        rewardType = DocumentDefaultValues.Empty.string
        credited = DocumentDefaultValues.Empty.string
        avtive = DocumentDefaultValues.Empty.bool
    }
}

// MARK: - Welcome
struct GetDailyResponse: Codable {
    let message: String
    let status: Int
    var CoinsEarned, rewardFlag: Int?
    
    var ReferrerRewardFlag: Int?
    var ReferrerRewardData: [CoinModel]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        CoinsEarned = try values.decodeIfPresent(Int.self, forKey: .CoinsEarned) ??  DocumentDefaultValues.Empty.int
        rewardFlag = try values.decodeIfPresent(Int.self, forKey: .rewardFlag) ??  DocumentDefaultValues.Empty.int
        
        ReferrerRewardFlag = try values.decodeIfPresent(Int.self, forKey: .ReferrerRewardFlag) ??  DocumentDefaultValues.Empty.int
        ReferrerRewardData = try values.decodeIfPresent([CoinModel].self, forKey: .ReferrerRewardData) ??  []
    }
    
    init() {
        status = DocumentDefaultValues.Empty.int
        message = DocumentDefaultValues.Empty.string
        CoinsEarned = DocumentDefaultValues.Empty.int
        rewardFlag = DocumentDefaultValues.Empty.int
        
        ReferrerRewardFlag = DocumentDefaultValues.Empty.int
        ReferrerRewardData = []
    }
}

struct CoinModel: Codable {
    let coinType, id: String
    let coins: Int

    enum CodingKeys: String, CodingKey {
        case coins = "Coins"
        case id = "_id"
        case coinType = "Coin_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coins = try values.decodeIfPresent(Int.self, forKey: .coins) ?? DocumentDefaultValues.Empty.int
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        coinType = try values.decodeIfPresent(String.self, forKey: .coinType) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        coins = DocumentDefaultValues.Empty.int
        id = DocumentDefaultValues.Empty.string
        coinType = DocumentDefaultValues.Empty.string
    }
}
