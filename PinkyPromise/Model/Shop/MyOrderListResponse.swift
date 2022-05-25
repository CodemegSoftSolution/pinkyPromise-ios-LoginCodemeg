//
//  MyOrderListResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 23/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct MyOrderListResponse: Codable {
    let status: Int
    let message: String
    let data: [OrderModel]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent([OrderModel].self, forKey: .data) ?? []
    }
}

// MARK: - Datum
struct OrderModel: Codable {
    let paidAmount: Int
    let paymentTimeStamp, /*shippingAddress,*/ razorPayStatus, razorpayOrderID: String
    let id: String
    let totalOrderAmount: Int
    let products: [Product]
    let paymentID, paymentAuthToken: String
    let orderID: Int
    let currency, orderStatus, userID: String
    let orderTimeStamp: String

    enum CodingKeys: String, CodingKey {
        case paidAmount = "PaidAmount"
        case paymentTimeStamp = "PaymentTimeStamp"
    //    case shippingAddress = "ShippingAddress"
        case razorPayStatus = "RazorPayStatus"
        case razorpayOrderID = "RazorpayOrderId"
        case id = "_id"
        case totalOrderAmount = "TotalOrderAmount"
        case products = "Products"
        case paymentID = "PaymentID"
        case paymentAuthToken = "PaymentAuthToken"
        case orderID = "OrderId"
        case currency = "Currency"
        case orderStatus = "OrderStatus"
        case userID = "UserID"
        case orderTimeStamp = "OrderTimeStamp"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        paymentTimeStamp = try values.decodeIfPresent(String.self, forKey: .paymentTimeStamp) ?? DocumentDefaultValues.Empty.string
        paidAmount = try values.decodeIfPresent(Int.self, forKey: .paidAmount) ?? DocumentDefaultValues.Empty.int
//        shippingAddress = try values.decodeIfPresent(String.self, forKey: .shippingAddress) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        razorPayStatus = try values.decodeIfPresent(String.self, forKey: .razorPayStatus) ?? DocumentDefaultValues.Empty.string
        razorpayOrderID = try values.decodeIfPresent(String.self, forKey: .razorpayOrderID) ?? DocumentDefaultValues.Empty.string
        paymentID = try values.decodeIfPresent(String.self, forKey: .paymentID) ?? DocumentDefaultValues.Empty.string
        paymentAuthToken = try values.decodeIfPresent(String.self, forKey: .paymentAuthToken) ?? DocumentDefaultValues.Empty.string
        currency = try values.decodeIfPresent(String.self, forKey: .currency) ?? DocumentDefaultValues.Empty.string
        orderTimeStamp = try values.decodeIfPresent(String.self, forKey: .orderTimeStamp) ?? DocumentDefaultValues.Empty.string
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus) ?? DocumentDefaultValues.Empty.string
        userID = try values.decodeIfPresent(String.self, forKey: .userID) ?? DocumentDefaultValues.Empty.string
        products = try values.decodeIfPresent([Product].self, forKey: .products) ?? []
        
        totalOrderAmount = try values.decodeIfPresent(Int.self, forKey: .totalOrderAmount) ?? DocumentDefaultValues.Empty.int
        orderID = try values.decodeIfPresent(Int.self, forKey: .orderID) ?? DocumentDefaultValues.Empty.int
    }

    
}

// MARK: - Product
struct Product: Codable {
    let qty, totalPrice, unitPrice: Int
    let productID: String

    enum CodingKeys: String, CodingKey {
        case qty = "Qty"
        case totalPrice = "TotalPrice"
        case unitPrice = "UnitPrice"
        case productID = "ProductID"
    }
}
