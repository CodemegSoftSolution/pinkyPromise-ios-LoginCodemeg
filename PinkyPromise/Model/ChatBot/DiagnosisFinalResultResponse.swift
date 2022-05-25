//
//  DiagnosisFinalResultResponse.swift
//  PinkyPromise
//
//  Created by AkshCom on 14/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation



struct DiagnosisFinalPdfResponse: Codable {
    let status: Int
    let message: String
    let fileURL: String
    
    enum CodingKeys: String, CodingKey {
        case status = "satus"
        case message, fileURL
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? DocumentDefaultValues.Empty.int
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? DocumentDefaultValues.Empty.string
        fileURL = try values.decodeIfPresent(String.self, forKey: .fileURL) ?? DocumentDefaultValues.Empty.string
    }
    
}
