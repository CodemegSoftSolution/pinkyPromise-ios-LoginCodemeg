//
//  UpdateDeviceTokenViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 13/11/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

struct UpdateDeviceTokenViewModel {
    func updateDeviceToken(request: /*[String: Any]*/UpdateTokenRequest,_ completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.updateDeviceToken, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(SuccessModel.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
                        break
                    default:
                        log.error("\(Log.stats()) \(success.message)")/
                    }
                }
                catch let err {
                    log.error("ERROR OCCURED WHILE DECODING: \(Log.stats()) \(err)")/
                }
            }
        }
    }
}
