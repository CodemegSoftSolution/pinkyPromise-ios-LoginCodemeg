//
//  GetQestionResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 08/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct GetQestionResponse: Codable {
    let status: Int
    let message: String
    let data: QuestionModel?
    let AddsFlag: Int?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent(QuestionModel.self, forKey: .data) ?? nil
        AddsFlag = try values.decodeIfPresent(Int.self, forKey: .AddsFlag) ?? DocumentDefaultValues.Empty.int
    }
    
    init() {
        status = DocumentDefaultValues.Empty.int
        message = DocumentDefaultValues.Empty.string
        data = nil
        AddsFlag = DocumentDefaultValues.Empty.int
    }
}

// MARK: - DataClass
struct QuestionModel: Codable {
    let tid, qid: Int
    let question, optionType: String
    let options: [OptionModel]

    enum CodingKeys: String, CodingKey {
        case tid = "TID"
        case qid = "QID"
        case question = "Question"
        case optionType = "OptionType"
        case options = "Options"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        question = try values.decodeIfPresent(String.self, forKey: .question) ?? DocumentDefaultValues.Empty.string
        tid = try values.decodeIfPresent(Int.self, forKey: .tid) ?? DocumentDefaultValues.Empty.int
        qid = try values.decodeIfPresent(Int.self, forKey: .qid) ?? DocumentDefaultValues.Empty.int
        optionType = try values.decodeIfPresent(String.self, forKey: .optionType) ?? DocumentDefaultValues.Empty.string
        options = try values.decodeIfPresent([OptionModel].self, forKey: .options) ?? []
    }
    
    init() {
        question = DocumentDefaultValues.Empty.string
        tid = DocumentDefaultValues.Empty.int
        qid = DocumentDefaultValues.Empty.int
        optionType = DocumentDefaultValues.Empty.string
        options = []
    }
    
}

// MARK: - Option
struct OptionModel: Codable {
    let id: Int
    let option: String
    let dest: Bool
    let nextRef: Int
    let refType: String
    let submitAnswers: Bool

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case option = "Option"
        case dest = "Dest"
        case nextRef = "NextRef"
        case refType = "RefType"
        case submitAnswers = "SubmitAnswers"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        refType = try values.decodeIfPresent(String.self, forKey: .refType) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        nextRef = try values.decodeIfPresent(Int.self, forKey: .nextRef) ?? DocumentDefaultValues.Empty.int
        option = try values.decodeIfPresent(String.self, forKey: .option) ?? DocumentDefaultValues.Empty.string
        dest = try values.decodeIfPresent(Bool.self, forKey: .dest) ?? DocumentDefaultValues.Empty.bool
        submitAnswers = try values.decodeIfPresent(Bool.self, forKey: .submitAnswers) ?? DocumentDefaultValues.Empty.bool
    }
}


