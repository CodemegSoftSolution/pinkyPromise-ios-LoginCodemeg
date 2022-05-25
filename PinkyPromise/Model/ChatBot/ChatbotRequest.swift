//
//  ChatbotRequest.swift
//  PinkyPromise
//
//  Created by AkshCom on 06/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct GetQuestionRequest: Codable {
    let user, lng: String?
    let SelectedOptions: [SelectedOption]?
    let QID, TID: Int?
    
    init(user: String? = nil, lng: String? = nil, QID: Int? = nil, TID: Int? = nil, SelectedOptions: [SelectedOption]? = nil){
        
        self.user = user
        self.lng = lng
        self.QID = QID
        self.TID = TID
        self.SelectedOptions = SelectedOptions
    }
}

// MARK: - SelectedOption
struct SelectedOption: Codable {
    var QID, ID: Int?
    var data: [IdRequest]?
    
    init(QID: Int? = nil, ID: Int? = nil, data: [IdRequest]? = nil) {
        self.QID = QID
        self.ID = ID
        self.data = data
    }
}

// MARK: - Datum
struct IdRequest: Codable {
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
    }
    
    init(id: Int? = nil) {
        self.id = id
    }
}


// MARK: - Welcome
struct GetDiagnosticRequest: Encodable {
    let lng, RefType, MsgId, user : String?
    let TID: Int?
    var SelectedOptions: [SelectedOption]?
    
    init(lng: String? = nil, RefType: String? = nil, MsgId: String? = nil, TID: Int? = nil, SelectedOptions: [SelectedOption]? = nil, user: String? = nil){
        
        self.lng = lng
        self.RefType = RefType
        self.MsgId = MsgId
        self.TID = TID
        self.SelectedOptions = SelectedOptions
        self.user = user
    }
}


struct GetDiagnosticPdf: Encodable {
    let lng : String?
    let TID, Flag, MsgId: Int?
    
    init(Flag: Int? = nil, MsgId: Int? = nil, lng: String? = nil, TID: Int? = nil){
        
        self.Flag = Flag
        self.MsgId = MsgId
        self.TID = TID
        self.lng = lng
    }
}
