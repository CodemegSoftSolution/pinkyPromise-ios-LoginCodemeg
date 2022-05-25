//
//  DiagnosticResultResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 11/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct DiagnosticResultResponse: Codable {
    let status: Int
    let message: String
    let data: DiagnosticResultModel?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent(DiagnosticResultModel.self, forKey: .data) ?? nil
    }
    
}

// MARK: - DataClass
struct DiagnosticResultModel: Codable {
    let refType, message, id, nextRef: String
    let msgID, tid: Int

    enum CodingKeys: String, CodingKey {
        case refType = "RefType"
        case nextRef = "NextRef"
        case message = "Message"
        case msgID = "MsgId"
        case tid = "TID"
        case id = "_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        refType = try values.decodeIfPresent(String.self, forKey: .refType) ?? DocumentDefaultValues.Empty.string
        tid = try values.decodeIfPresent(Int.self, forKey: .tid) ?? DocumentDefaultValues.Empty.int
        msgID = try values.decodeIfPresent(Int.self, forKey: .msgID) ?? DocumentDefaultValues.Empty.int
        nextRef = try values.decodeIfPresent(String.self, forKey: .nextRef) ?? DocumentDefaultValues.Empty.string
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
    }
    
}







// MARK: - Welcome
struct DiagnosticChatRoom1ResultResponse: Codable {
    let status: Int
    let message: String
    let data: DiagnosticChatRoom1ResultModel?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent(DiagnosticChatRoom1ResultModel.self, forKey: .data) ?? nil
    }
}

// MARK: - DataClass
struct DiagnosticChatRoom1ResultModel: Codable {
    let refType, message, id: String
    let msgID, tid, nextRef: Int
    let diagnosis2: Bool
    
    let DiagnosisResponse: Bool  // only for TID : 7
    let qid: Int

    enum CodingKeys: String, CodingKey {
        case refType = "RefType"
        case nextRef = "NextRef"
        case message = "Message"
        case msgID = "MsgId"
        case tid = "TID"
        case id = "_id"
        case diagnosis2, DiagnosisResponse
        
        case qid = "QID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        refType = try values.decodeIfPresent(String.self, forKey: .refType) ?? DocumentDefaultValues.Empty.string
        tid = try values.decodeIfPresent(Int.self, forKey: .tid) ?? DocumentDefaultValues.Empty.int
        msgID = try values.decodeIfPresent(Int.self, forKey: .msgID) ?? DocumentDefaultValues.Empty.int
        nextRef = try values.decodeIfPresent(Int.self, forKey: .nextRef) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        diagnosis2 = try values.decodeIfPresent(Bool.self, forKey: .diagnosis2) ?? DocumentDefaultValues.Empty.bool
        DiagnosisResponse = try values.decodeIfPresent(Bool.self, forKey: .DiagnosisResponse) ?? true
        
        qid = try values.decodeIfPresent(Int.self, forKey: .qid) ?? DocumentDefaultValues.Empty.int
    }
}
