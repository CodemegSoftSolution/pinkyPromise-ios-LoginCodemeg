//
//  LoginViewModel.swift
//  InstantFest
//
//  Created by iMac on 6/17/21.
//

import Foundation

protocol LoginDelegate {
    func didRecieveLoginResponse(response: LoginResponse)
}

struct LoginViewModel {
    var delegate: LoginDelegate?
    
    func userLogin(request: LoginRequest) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.login, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(LoginResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        self.delegate?.didRecieveLoginResponse(response: success.self)
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

