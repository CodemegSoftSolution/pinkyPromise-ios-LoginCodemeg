//
//  BedgesRequest.swift
//  PinkyPromise
//
//  Created by AkshCom on 21/01/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import Foundation


// MARK: - SelectedOption
struct BedgesAppRequest: Encodable {
    var UserID: String
    var RedeemCoins: Int?
    var appState: String?
}

struct UpdateCoinRequest: Encodable {
    var UserID: String
    var RedeemedCoins: Int
}


// MARK: - SelectedOption
struct BedgesUpdateRequest: Encodable {
    var UserID: String
    var Data: [BedgesUpdateListRequest]
}

struct BedgesUpdateListRequest: Encodable {
    var id: String
    var badge: String
    var read: Bool

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case badge = "Badge"
        case read = "Read"
    }
}
