//
//  AddDefaulLanguageViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 03/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

struct AddDefaulLanguageViewModel {
    func addDefaultLanguage(request: AddLanguageRequest, completion: @escaping (_ response: UpdateProfileResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.addLanguage, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(UpdateProfileResponse.self, from: response!) // decode the response into model
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
    
    func verifyPhoneNumber(request: VerifyPhoneNumberRequest, completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.verifyNumber, Loader: true, isMultipart: false) { (response) in
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
    
    func verifyRefferalCode(request: VerifyRequest, completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.VerifyReferalCode, Loader: true, isMultipart: false) { (response) in
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
    
    func verifyOtp(request: VerifyOtpRequest, completion: @escaping (_ response: LoginResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.verifyOtp, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(LoginResponse.self, from: response!) // decode the response into model
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
