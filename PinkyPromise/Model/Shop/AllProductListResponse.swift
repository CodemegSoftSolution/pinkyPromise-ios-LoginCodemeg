//
//  AllProductListResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 18/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct AllProductListResponse: Codable {
    let status: Int
    let message: String
    let data: [ProductListModel]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        data = try values.decodeIfPresent([ProductListModel].self, forKey: .data) ?? []
    }
    
}

// MARK: - Datum
struct ProductListModel: Codable {
    let productDescription: String
    let imagesPath: [String]
    let unitPrice: Int
    let timeStamp, id, productName, productDescriptionBrief: String
    let productID: String
    let productImage: String
    let productUsage, currency, productDescriptionShort: String
    var cartCount, enterCoin: Int
    var totalAmount: Int

    enum CodingKeys: String, CodingKey {
        case productDescription = "ProductDescription"
        case imagesPath
        case unitPrice = "UnitPrice"
        case timeStamp = "TimeStamp"
        case id = "_id"
        case productName = "ProductName"
        case productDescriptionBrief = "ProductDescriptionBrief"
        case productID = "ProductID"
        case productImage = "ProductImage"
        case productUsage = "ProductUsage"
        case currency = "Currency"
        case productDescriptionShort = "ProductDescriptionShort"
        case cartCount, totalAmount, enterCoin
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription) ?? DocumentDefaultValues.Empty.string
        unitPrice = try values.decodeIfPresent(Int.self, forKey: .unitPrice) ?? DocumentDefaultValues.Empty.int
        timeStamp = try values.decodeIfPresent(String.self, forKey: .timeStamp) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        productName = try values.decodeIfPresent(String.self, forKey: .productName) ?? DocumentDefaultValues.Empty.string
        productDescriptionBrief = try values.decodeIfPresent(String.self, forKey: .productDescriptionBrief) ?? DocumentDefaultValues.Empty.string
        productID = try values.decodeIfPresent(String.self, forKey: .productID) ?? DocumentDefaultValues.Empty.string
        productImage = try values.decodeIfPresent(String.self, forKey: .productImage) ?? DocumentDefaultValues.Empty.string
        productUsage = try values.decodeIfPresent(String.self, forKey: .productUsage) ?? DocumentDefaultValues.Empty.string
        currency = try values.decodeIfPresent(String.self, forKey: .currency) ?? DocumentDefaultValues.Empty.string
        productDescriptionShort = try values.decodeIfPresent(String.self, forKey: .productDescriptionShort) ?? DocumentDefaultValues.Empty.string
        imagesPath = try values.decodeIfPresent([String].self, forKey: .imagesPath) ?? []
        
        cartCount = try values.decodeIfPresent(Int.self, forKey: .cartCount) ?? DocumentDefaultValues.Empty.int
        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount) ?? DocumentDefaultValues.Empty.int
        enterCoin = try values.decodeIfPresent(Int.self, forKey: .enterCoin) ?? DocumentDefaultValues.Empty.int
    }
    
}

