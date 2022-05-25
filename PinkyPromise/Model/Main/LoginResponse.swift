//
//  LoginResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 03/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct LoginResponse: Codable {
    let message: String
    let status: Int
    let data: UserDataModel?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent(UserDataModel.self, forKey: .data) ?? nil
    }
}

// MARK: - DataClass
struct UserDataModel: Codable {
    var accesstoken: String
    var userdata: UserModel?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accesstoken = try values.decodeIfPresent(String.self, forKey: .accesstoken) ?? DocumentDefaultValues.Empty.string
        userdata = try values.decodeIfPresent(UserModel.self, forKey: .userdata) ?? nil
    }
    
    init() {
        accesstoken = DocumentDefaultValues.Empty.string
        userdata = UserModel.init()
    }
}

// MARK: - Userdata
struct UserModel: Codable {
    let mobilenumber, updatedAt: String
    let otp: Int
    let userLocationInfo: UserLocationInfo?
    let acceptterms: Bool
    var id: String
    let mobilenumberverified, isSocialMedia: Bool
    let profilecomplete: Bool
    let defaultLanguage: String
    let v: Int
    let socialmedialogintype, email: String
    let rememberme: Bool
    let createdAt: String
    let userid: String     // id and userid both are same when i do forgot password i get userid
    
    let weight: HeightModel?
    let chatroomperference: [ChatRoomPerferenceModel]
    let dob: String
    let gender, divicetoken: String
    let height: HeightModel?
    let username: String
    let rewardFlag, CoinsEarned: Int
    
    
    enum CodingKeys: String, CodingKey {
        case mobilenumber, weight, chatroomperference
        case v = "__v"
        case dob
        case userLocationInfo = "UserLocationInfo"
        case id = "_id"
        case socialmedialogintype, createdAt, rememberme, acceptterms, defaultLanguage, mobilenumberverified, updatedAt
        case isSocialMedia = "IsSocialMedia"
        case otp, gender, email, divicetoken, height, profilecomplete, username, userid, rewardFlag, CoinsEarned
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        otp = try values.decodeIfPresent(Int.self, forKey: .otp) ?? DocumentDefaultValues.Empty.int
        v = try values.decodeIfPresent(Int.self, forKey: .v) ?? DocumentDefaultValues.Empty.int
        acceptterms = try values.decodeIfPresent(Bool.self, forKey: .acceptterms) ?? DocumentDefaultValues.Empty.bool
        mobilenumberverified = try values.decodeIfPresent(Bool.self, forKey: .mobilenumberverified) ?? DocumentDefaultValues.Empty.bool
        isSocialMedia = try values.decodeIfPresent(Bool.self, forKey: .isSocialMedia) ?? DocumentDefaultValues.Empty.bool
        profilecomplete = try values.decodeIfPresent(Bool.self, forKey: .profilecomplete) ?? DocumentDefaultValues.Empty.bool
        rememberme = try values.decodeIfPresent(Bool.self, forKey: .rememberme) ?? DocumentDefaultValues.Empty.bool
        mobilenumber = try values.decodeIfPresent(String.self, forKey: .mobilenumber) ?? DocumentDefaultValues.Empty.string
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        defaultLanguage = try values.decodeIfPresent(String.self, forKey: .defaultLanguage) ?? DocumentDefaultValues.Empty.string
        socialmedialogintype = try values.decodeIfPresent(String.self, forKey: .socialmedialogintype) ?? DocumentDefaultValues.Empty.string
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? DocumentDefaultValues.Empty.string
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? DocumentDefaultValues.Empty.string
        userLocationInfo = try values.decodeIfPresent(UserLocationInfo.self, forKey: .userLocationInfo) ?? nil
        userid = try values.decodeIfPresent(String.self, forKey: .userid) ?? DocumentDefaultValues.Empty.string
        
        dob = try values.decodeIfPresent(String.self, forKey: .dob) ?? DocumentDefaultValues.Empty.string
        gender = try values.decodeIfPresent(String.self, forKey: .gender) ?? DocumentDefaultValues.Empty.string
        divicetoken = try values.decodeIfPresent(String.self, forKey: .divicetoken) ?? DocumentDefaultValues.Empty.string
        username = try values.decodeIfPresent(String.self, forKey: .username) ?? DocumentDefaultValues.Empty.string
        weight = try values.decodeIfPresent(HeightModel.self, forKey: .weight) ?? nil
        height = try values.decodeIfPresent(HeightModel.self, forKey: .height) ?? nil
        chatroomperference = try values.decodeIfPresent([ChatRoomPerferenceModel].self, forKey: .chatroomperference) ?? []
        
        rewardFlag = try values.decodeIfPresent(Int.self, forKey: .rewardFlag) ?? DocumentDefaultValues.Empty.int
        CoinsEarned = try values.decodeIfPresent(Int.self, forKey: .CoinsEarned) ?? DocumentDefaultValues.Empty.int
        
        if userid != "" {
            id = userid
        }
    }
    
    init() {
        otp = DocumentDefaultValues.Empty.int
        v = DocumentDefaultValues.Empty.int
        acceptterms = DocumentDefaultValues.Empty.bool
        mobilenumberverified = DocumentDefaultValues.Empty.bool
        isSocialMedia = DocumentDefaultValues.Empty.bool
        profilecomplete = DocumentDefaultValues.Empty.bool
        rememberme = DocumentDefaultValues.Empty.bool
        mobilenumber = DocumentDefaultValues.Empty.string
        updatedAt = DocumentDefaultValues.Empty.string
        id = DocumentDefaultValues.Empty.string
        defaultLanguage = DocumentDefaultValues.Empty.string
        socialmedialogintype = DocumentDefaultValues.Empty.string
        email = DocumentDefaultValues.Empty.string
        createdAt = DocumentDefaultValues.Empty.string
        userLocationInfo = nil
        userid = DocumentDefaultValues.Empty.string
        
        dob = DocumentDefaultValues.Empty.string
        gender = DocumentDefaultValues.Empty.string
        divicetoken = DocumentDefaultValues.Empty.string
        username = DocumentDefaultValues.Empty.string
        weight = nil
        height = nil
        chatroomperference = []
        
        rewardFlag = DocumentDefaultValues.Empty.int
        CoinsEarned = DocumentDefaultValues.Empty.int
    }
}

// MARK: - UserLocationInfo
struct UserLocationInfo: Codable {
    let ip: String
    let locationInfo: LocationInfo?

    enum CodingKeys: String, CodingKey {
        case ip = "IP"
        case locationInfo = "LocationInfo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ip = try values.decodeIfPresent(String.self, forKey: .ip) ?? DocumentDefaultValues.Empty.string
        locationInfo = try values.decodeIfPresent(LocationInfo.self, forKey: .locationInfo) ?? nil
    }
}


// MARK: - Eight
struct HeightModel: Codable {
    let measure: Int
    let unit: String
    
    enum CodingKeys: String, CodingKey {
        case measure, unit
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        unit = try values.decodeIfPresent(String.self, forKey: .unit) ?? DocumentDefaultValues.Empty.string
        measure = try values.decodeIfPresent(Int.self, forKey: .measure) ?? DocumentDefaultValues.Empty.int
    }
}

// MARK: - LocationInfo
struct LocationInfo: Codable {
    let region, city, country: String
    let area: Int
    let eu: String
    let range: [Int]
    let timezone: String
    let ll: [Double]
    let metro: Int
    
    
    enum CodingKeys: String, CodingKey {
        case region, city, country
        case area
        case eu
        case range
        case timezone
        case ll
        case metro
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        area = try values.decodeIfPresent(Int.self, forKey: .area) ?? DocumentDefaultValues.Empty.int
        range = try values.decodeIfPresent([Int].self, forKey: .range) ?? []
        metro = try values.decodeIfPresent(Int.self, forKey: .metro) ?? DocumentDefaultValues.Empty.int
        region = try values.decodeIfPresent(String.self, forKey: .region) ?? DocumentDefaultValues.Empty.string
        city = try values.decodeIfPresent(String.self, forKey: .city) ?? DocumentDefaultValues.Empty.string
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? DocumentDefaultValues.Empty.string
        eu = try values.decodeIfPresent(String.self, forKey: .eu) ?? DocumentDefaultValues.Empty.string
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone) ?? DocumentDefaultValues.Empty.string
        ll = try values.decodeIfPresent([Double].self, forKey: .ll) ?? []
    }
}

// MARK: - Chatroomperference
struct ChatRoomPerferenceModel: Codable {
    let infoID, latSeenMessageID, priority: Int
    let chatRoomName, chatRoomID: String
    let active: Bool

    enum CodingKeys: String, CodingKey {
        case infoID = "InfoID"
        case latSeenMessageID = "LatSeenMessageID"
        case priority = "Priority"
        case chatRoomName = "ChatRoomName"
        case chatRoomID = "ChatRoomID"
        case active = "Active"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        infoID = try values.decodeIfPresent(Int.self, forKey: .infoID) ?? DocumentDefaultValues.Empty.int
        priority = try values.decodeIfPresent(Int.self, forKey: .priority) ?? DocumentDefaultValues.Empty.int
        latSeenMessageID = try values.decodeIfPresent(Int.self, forKey: .latSeenMessageID) ?? DocumentDefaultValues.Empty.int
        chatRoomName = try values.decodeIfPresent(String.self, forKey: .chatRoomName) ?? DocumentDefaultValues.Empty.string
        chatRoomID = try values.decodeIfPresent(String.self, forKey: .chatRoomID) ?? DocumentDefaultValues.Empty.string
        active = try values.decodeIfPresent(Bool.self, forKey: .active) ?? DocumentDefaultValues.Empty.bool
    }
    
    init() {
        infoID = DocumentDefaultValues.Empty.int
        priority = DocumentDefaultValues.Empty.int
        latSeenMessageID = DocumentDefaultValues.Empty.int
        chatRoomName = DocumentDefaultValues.Empty.string
        chatRoomID = DocumentDefaultValues.Empty.string
        active = DocumentDefaultValues.Empty.bool
    }
}
