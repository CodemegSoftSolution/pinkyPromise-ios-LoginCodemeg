//
//  ShopRequest.swift
//  PinkyPromise
//
//  Created by AkshCom on 21/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct GenerateOrderRequest: Codable {
    let UserID: String?
    let Products: [ProductRequest]?
    let Address: AddressModel?
    var TotalOrderAmount, RedeemedCoins: Int?
    var CouponCode: String?
    var isCouponCodeVerified: Bool?
    
    init(UserID: String? = nil, Address: AddressModel? = nil, Products: [ProductRequest]? = nil, TotalOrderAmount: Int? = nil, RedeemedCoins: Int? = nil, CouponCode: String? = nil, isCouponCodeVerified: Bool? = nil){
        self.UserID = UserID
        self.Address = Address
        self.Products = Products
        
        self.TotalOrderAmount = TotalOrderAmount
        self.RedeemedCoins = RedeemedCoins
        
        self.CouponCode = CouponCode
        self.isCouponCodeVerified = isCouponCodeVerified
    }
}

struct AddressModel: Codable {
    let Address1, Address2: String?
    let City, Country: String?
    let CountryCode, Name: String?
    let PostalCode, State: String?
    
    
    init(Address1: String? = nil, Address2: String? = nil, City: String? = nil, Country: String? = nil, CountryCode: String? = nil, Name: String? = nil, PostalCode: String? = nil, State: String? = nil){
        self.Address1 = Address1
        self.Address2 = Address2
        self.City = City
        self.Country = Country
        self.CountryCode = CountryCode
        self.Name = Name
        self.PostalCode = PostalCode
        self.State = State
    }
}


// MARK: - Datum
struct ProductRequest: Codable {
    var qty: Int?
    var unitPrice: Int?
    var totalPrice: Int?
    var productId: String?
    var reedemCoin: Int?
    
    enum CodingKeys: String, CodingKey {
        case qty = "Qty"
        case unitPrice = "UnitPrice"
        case totalPrice = "TotalPrice"
        case productId = "ProductID"
        case reedemCoin = "RedeemedCoins"
    }
    
    init(qty: Int? = nil, unitPrice: Int? = nil, totalPrice: Int? = nil, productId: String? = nil, reedemCoin: Int? = nil) {
        self.qty = qty
        self.unitPrice = unitPrice
        self.totalPrice = totalPrice
        self.productId = productId
        self.reedemCoin = reedemCoin
    }
}


struct AddressRequest: Codable {
    var name: String?
    var addressLine1, addressLine2: String?
    var pinCode, city, state: String?
    
    init(name: String? = nil, addressLine1: String? = nil, addressLine2: String? = nil, city: String? = nil, state: String? = nil, pinCode: String? = nil) {
        
        self.name = name
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.pinCode = pinCode
        self.city = city
        self.state = state
    }
}

struct MyOrderRequest: Codable {
    let userId: String?
    let nextIndex: Int?
    let requiredProducts: Int?
    
    init(userId: String? = nil, nextIndex: Int? = nil, requiredProducts: Int? = nil){
        self.userId = userId
        self.nextIndex = nextIndex
        self.requiredProducts = requiredProducts
    }
}

struct CancelOrderRequest: Codable {
    let userId: String?
    let orderId: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "UserID"
        case orderId = "OrderID"
    }
}

struct PaymentOrderRequest: Codable {
    let userId: String?
    let orderId: String?
    let paymentId: String?
    let paymentSignature: String?
    var CouponCode: String?
    var isCouponCodeVerified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userId = "UserID"
        case orderId = "OrderID"
        case paymentId = "PaymentId"
        case paymentSignature = "PaymentSignature"
        case CouponCode, isCouponCodeVerified
    }
    
    init(userId: String? = nil, orderId: String? = nil, paymentId: String? = nil, paymentSignature: String? = nil, CouponCode: String? = nil, isCouponCodeVerified: Bool? = nil){
        self.userId = userId
        self.orderId = orderId
        self.paymentId = paymentId
        self.paymentSignature = paymentSignature
        
        self.CouponCode = CouponCode
        self.isCouponCodeVerified = isCouponCodeVerified
    }
}


// MARK: - Welcome
struct ApplyCouponRequest: Codable {
    let CouponCode: String?
    let Products: [ProductRequest]?
    
    init(CouponCode: String? = nil, Products: [ProductRequest]? = nil){
        self.CouponCode = CouponCode
        self.Products = Products
       
    }
}
