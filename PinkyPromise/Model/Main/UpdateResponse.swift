//
//  UpdateResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 16/11/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct UpdateResponse: Codable {
    let status: Int
    let message: String
    let data: AppUpdate?

    enum CodingKeys: String, CodingKey {
        case status, message
        case data = "Data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent(AppUpdate.self, forKey: .data) ?? nil
    }
}

// MARK: - DataClass
struct AppUpdate: Codable {
    let currentVersion: String
    let currentVersionUpdated: String
    let previousVersion: String
    let previousVersionUpdated: String

    enum CodingKeys: String, CodingKey {
        case currentVersion = "current_version"
        case currentVersionUpdated = "current_version_updated"
        case previousVersion = "previous_version"
        case previousVersionUpdated = "previous_version_updated"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currentVersion = try values.decodeIfPresent(String.self, forKey: .currentVersion) ?? DocumentDefaultValues.Empty.string
        currentVersionUpdated = try values.decodeIfPresent(String.self, forKey: .currentVersionUpdated) ?? DocumentDefaultValues.Empty.string
        previousVersion = try values.decodeIfPresent(String.self, forKey: .previousVersion) ?? DocumentDefaultValues.Empty.string
        previousVersionUpdated = try values.decodeIfPresent(String.self, forKey: .previousVersionUpdated) ?? DocumentDefaultValues.Empty.string
    }
}


