//
//  AppModel.swift
//  cwrnch-ios
//
//  Created by App Knit on 27/12/19.
//  Copyright © 2019 Sukhmani. All rights reserved.
//

import Foundation
//MARK: - AppModel
class AppModel: NSObject {
    static let shared = AppModel()
    
    var currentUser: UserDataModel!
    var isGuestUser: Bool = Bool()
    var fcmToken: String = ""
    var token = ""
    var device = "iOS"
    var countryCodes: [CountryCodeModel]!
    
    func resetAllModel()
    {
        currentUser = nil
        fcmToken = ""
        token = ""
        isGuestUser = Bool()
    }
    
    func getIntValue(_ dict : [String : Any], _ key : String) -> Int {
        if let temp = dict[key] as? Int {
            return temp
        }
        else if let temp = dict[key] as? String, temp != "" {
            return Int(temp)!
        }
        else if let temp = dict[key] as? Float {
            return Int(temp)
        }
        else if let temp = dict[key] as? Double {
            return Int(temp)
        }
        return 0
    }
    
}

// MARK: - SuccessModel
struct SuccessModel: Codable {
    let status: Int
    let message, format, timestamp: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        format = try values.decodeIfPresent(String.self, forKey: .format) ?? DocumentDefaultValues.Empty.string
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        status = DocumentDefaultValues.Empty.int
        message = DocumentDefaultValues.Empty.string
        format = DocumentDefaultValues.Empty.string
        timestamp = DocumentDefaultValues.Empty.string
    }
}


// MARK: - CountryCodeModel
struct CountryCodeModel: Codable {
    let name, dialCode, code, flag: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case dialCode = "dial_code"
        case code, flag
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DocumentDefaultValues.Empty.string
        dialCode = try values.decodeIfPresent(String.self, forKey: .dialCode) ?? DocumentDefaultValues.Empty.string
        code = try values.decodeIfPresent(String.self, forKey: .code) ?? DocumentDefaultValues.Empty.string
        flag = try values.decodeIfPresent(String.self, forKey: .flag) ?? DocumentDefaultValues.Empty.string
    }
}


// MARK: - CountryCodeModel
struct FaqListModel: Codable {
    let question, answer: String
    
    enum CodingKeys: String, CodingKey {
        case question
        case answer
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        question = try values.decodeIfPresent(String.self, forKey: .question) ?? DocumentDefaultValues.Empty.string
        answer = try values.decodeIfPresent(String.self, forKey: .answer) ?? DocumentDefaultValues.Empty.string
    }
}
