//
//  RegisterViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 03/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

protocol RegisterDelegate {
    func didRecieveRegisterResponse(response: LoginResponse)
}

struct RegisterViewModel {
    var delegate: RegisterDelegate?
    
    func userLogin(request: SignupRequest) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.signUp, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(LoginResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        self.delegate?.didRecieveRegisterResponse(response: success.self)
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

