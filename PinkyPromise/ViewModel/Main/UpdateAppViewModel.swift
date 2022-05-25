//
//  UpdateAppViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 16/11/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

struct UpdateAppViewModel {
    func updateApp(_ completion: @escaping (_ response: UpdateResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: [String : Any](), api: API.USER.updateAppVersion, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(UpdateResponse.self, from: response!) // decode the response into model
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


