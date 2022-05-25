//
//  GenerateOrderResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 22/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct GenerateOrderResponse: Codable {
    let status: Int
    let message: String
    let data: GenerateOrderModel?
    let orderID: String

    enum CodingKeys: String, CodingKey {
        case status, message
        case data = "Data"
        case orderID = "OrderID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent(GenerateOrderModel.self, forKey: .data) ?? nil
        orderID = try values.decodeIfPresent(String.self, forKey: .orderID) ?? DocumentDefaultValues.Empty.string
    }
    
}

// MARK: - DataClass
struct GenerateOrderModel: Codable {
    let id, entity: String
    let amountPaid, amount, createdAt, amountDue: Int
//    let offerID: Int?
    let attempts: Int
//    let notes: [String]
    let receipt, currency, status: String

    enum CodingKeys: String, CodingKey {
        case id, entity
        case amountPaid = "amount_paid"
        case amount
        case createdAt = "created_at"
        case amountDue = "amount_due"
//        case offerID = "offer_id"
        case attempts, receipt, currency, status //, notes
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        entity = try values.decodeIfPresent(String.self, forKey: .entity) ?? DocumentDefaultValues.Empty.string
        amountPaid = try values.decodeIfPresent(Int.self, forKey: .amountPaid) ?? DocumentDefaultValues.Empty.int
        amount = try values.decodeIfPresent(Int.self, forKey: .amount) ?? DocumentDefaultValues.Empty.int
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt) ?? DocumentDefaultValues.Empty.int
        amountDue = try values.decodeIfPresent(Int.self, forKey: .amountDue) ?? DocumentDefaultValues.Empty.int
//        offerID = try values.decodeIfPresent(Int.self, forKey: .offerID) ?? DocumentDefaultValues.Empty.int
        attempts = try values.decodeIfPresent(Int.self, forKey: .attempts) ?? DocumentDefaultValues.Empty.int
        
        receipt = try values.decodeIfPresent(String.self, forKey: .receipt) ?? DocumentDefaultValues.Empty.string
        currency = try values.decodeIfPresent(String.self, forKey: .currency) ?? DocumentDefaultValues.Empty.string
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? DocumentDefaultValues.Empty.string
//        notes = try values.decodeIfPresent([String].self, forKey: .notes) ?? []
    }
    
}


// MARK: - Welcome
struct ApplyCouponResponse: Codable {
    let TotalAmount, totalDiscountedAmount: Int
    var message, couponCode: String
    let result, isCouponCodeVerified: Bool

    enum CodingKeys: String, CodingKey {
        case TotalAmount, totalDiscountedAmount
        case message = "Message"
        case isCouponCodeVerified, result, couponCode
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        TotalAmount = try values.decodeIfPresent(Int.self, forKey: .TotalAmount) ?? DocumentDefaultValues.Empty.int
        totalDiscountedAmount = try values.decodeIfPresent(Int.self, forKey: .totalDiscountedAmount) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        result = try values.decodeIfPresent(Bool.self, forKey: .result) ?? DocumentDefaultValues.Empty.bool
        isCouponCodeVerified = try values.decodeIfPresent(Bool.self, forKey: .isCouponCodeVerified) ?? DocumentDefaultValues.Empty.bool
        couponCode = try values.decodeIfPresent(String.self, forKey: .couponCode) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        TotalAmount = DocumentDefaultValues.Empty.int
        totalDiscountedAmount = DocumentDefaultValues.Empty.int
        message = DocumentDefaultValues.Empty.string
        result = DocumentDefaultValues.Empty.bool
        isCouponCodeVerified = DocumentDefaultValues.Empty.bool
        couponCode = DocumentDefaultValues.Empty.string
    }
    
}
