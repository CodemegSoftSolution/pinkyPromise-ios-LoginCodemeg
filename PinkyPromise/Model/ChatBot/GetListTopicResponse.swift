//
//  GetListTopicResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 06/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct GetListTopicResponse: Codable {
    let status: Int
    let message: String
    let data: [TopicModel]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent([TopicModel].self, forKey: .data) ?? []
    }
}


// MARK: - Datum
struct TopicModel: Codable {
    let tid: Int
    let topic, topicHeader: String
    let refID: Int
    let icon: String
    let introMessages: [IntroMessage]

    enum CodingKeys: String, CodingKey {
        case tid = "TID"
        case topic = "Topic"
        case topicHeader = "TopicHeader"
        case refID = "RefID"
        case icon = "Icon"
        case introMessages = "IntroMessages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        topic = try values.decodeIfPresent(String.self, forKey: .topic) ?? DocumentDefaultValues.Empty.string
        tid = try values.decodeIfPresent(Int.self, forKey: .tid) ?? DocumentDefaultValues.Empty.int
        refID = try values.decodeIfPresent(Int.self, forKey: .refID) ?? DocumentDefaultValues.Empty.int
        topicHeader = try values.decodeIfPresent(String.self, forKey: .topicHeader) ?? DocumentDefaultValues.Empty.string
        icon = try values.decodeIfPresent(String.self, forKey: .icon) ?? DocumentDefaultValues.Empty.string
        introMessages = try values.decodeIfPresent([IntroMessage].self, forKey: .introMessages) ?? []
    }
    
    init() {
        topic = DocumentDefaultValues.Empty.string
        tid = DocumentDefaultValues.Empty.int
        refID = DocumentDefaultValues.Empty.int
        topicHeader = DocumentDefaultValues.Empty.string
        icon = DocumentDefaultValues.Empty.string
        introMessages = []
    }
    
}

// MARK: - IntroMessage
struct IntroMessage: Codable {
    let id: Int
    let message, response: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case message = "Message"
        case response = "Response"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        response = try values.decodeIfPresent(String.self, forKey: .response) ?? DocumentDefaultValues.Empty.string
    }
}


enum ID: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ID"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
