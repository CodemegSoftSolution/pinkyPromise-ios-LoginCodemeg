//
//  ResetPasswordViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 03/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

protocol ResetPasswordDelegate {
    func didRecieveResetPasswordResponse(response: LoginResponse)
}

struct ResetPasswordViewModel {
    var delegate: ResetPasswordDelegate?
    
    func changePassword(request: ResetPasswordRequest) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.changePassword, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(LoginResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        self.delegate?.didRecieveResetPasswordResponse(response: success.self)
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
