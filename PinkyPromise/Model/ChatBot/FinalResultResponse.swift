//
//  FinalResultResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 13/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct FinalResultResponse: Codable {
    let status: Int
    let message: String
    let data: [FinalDiagnosticModel]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent([FinalDiagnosticModel].self, forKey: .data) ?? []
    }
}

// MARK: - Datum
struct FinalDiagnosticModel: Codable {
    let datumID: String
    let resultData: [ResultModel]
    let type, name: String
    let tid, id: Int
    let resultType: String
    
    let mainMessage: String

    enum CodingKeys: String, CodingKey {
        case datumID = "_id"
        case resultData = "ResultData"
        case type = "Type"
        case name = "Name"
        case tid = "TID"
        case id = "ID"
        case resultType = "ResultType"
        case mainMessage = "MainMessage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        datumID = try values.decodeIfPresent(String.self, forKey: .datumID) ?? DocumentDefaultValues.Empty.string
        tid = try values.decodeIfPresent(Int.self, forKey: .tid) ?? DocumentDefaultValues.Empty.int
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? DocumentDefaultValues.Empty.string
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DocumentDefaultValues.Empty.string
        resultType = try values.decodeIfPresent(String.self, forKey: .resultType) ?? DocumentDefaultValues.Empty.string
        resultData = try values.decodeIfPresent([ResultModel].self, forKey: .resultData) ?? []
        
        mainMessage = try values.decodeIfPresent(String.self, forKey: .mainMessage) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        datumID = DocumentDefaultValues.Empty.string
        tid = DocumentDefaultValues.Empty.int
        id = DocumentDefaultValues.Empty.int
        type = DocumentDefaultValues.Empty.string
        name = DocumentDefaultValues.Empty.string
        resultType = DocumentDefaultValues.Empty.string
        mainMessage = DocumentDefaultValues.Empty.string
        resultData = []
    }
    
}

// MARK: - ResultDatum
struct ResultModel: Codable {
    let header, info: String

    enum CodingKeys: String, CodingKey {
        case header = "Header"
        case info = "Info"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        header = try values.decodeIfPresent(String.self, forKey: .header) ?? DocumentDefaultValues.Empty.string
        info = try values.decodeIfPresent(String.self, forKey: .info) ?? DocumentDefaultValues.Empty.string
    }
    
}






//// MARK: - Welcome
//struct Diagnostic2Response: Codable {
//    let status: Int
//    let message: String
//    let data: DataClass
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let id: String
//    let msgID: Int
//    let diagnosis2: Bool
//    let refType: String
//    let nextRef, tid: Int
//    let message: String
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case msgID = "MsgId"
//        case diagnosis2
//        case refType = "RefType"
//        case nextRef = "NextRef"
//        case tid = "TID"
//        case message = "Message"
//    }
//}
