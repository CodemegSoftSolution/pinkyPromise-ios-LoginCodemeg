//
//  CreateAccountViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 03/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

//protocol CreateAccountDelegate {
//    func didRecieveCreateAccountResponse(response: UpdateProfileResponswe)
//}

struct CreateAccountViewModel {
    func createAccount(request: CreateAccountRequest,_ completion: @escaping (_ response: UpdateProfileResponse) -> Void) {   //CreateAccountRequest
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.createAccount, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(UpdateProfileResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
                      //  self.delegate?.didRecieveCreateAccountResponse(response: success.self)
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
    
    func getUserDetail(request: UserDetailRequest,_ completion: @escaping (_ response: UpdateProfileResponse) -> Void) {   //CreateAccountRequest
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.getProfile, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(UpdateProfileResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
                      //  self.delegate?.didRecieveCreateAccountResponse(response: success.self)
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
