//
//  BadgesViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 21/01/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import Foundation


struct BadgesViewModel {
    
    func serviceCallToAppOpen(request: BedgesAppRequest, _ completion: @escaping (_ response: GetDailyResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.AppOnOpen, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(GetDailyResponse.self, from: response!) // decode the response into model
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
    
    func serviceCallToAppClose(request: BedgesAppRequest, _ completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.AppOnClose, Loader: true, isMultipart: false) { (response) in
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
    
    func serviceCallToAppInstall30Days(request: BedgesAppRequest, _ completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.AppInstalledFor30Days, Loader: true, isMultipart: false) { (response) in
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
    
    func serviceCallToGetUsersTotalCoin(request: BedgesAppRequest, _ completion: @escaping (_ response: TotalBedgesResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.gerUserTotalCoins, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(TotalBedgesResponse.self, from: response!) // decode the response into model
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
    
    func serviceCallToGetRedeemUserCoin(request: BedgesAppRequest, _ completion: @escaping (_ response: RedeemModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.RedeemUserCoins, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(RedeemBedgesResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion((success.data ?? RedeemModel.init()).self)
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
    
    func serviceCallToGetRedeemCoinUpdate(request: UpdateCoinRequest, _ completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.RedeemUserCoinsUpdate, Loader: true, isMultipart: false) { (response) in
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
    
    func serviceCallToGetUserBedges(request: BedgesAppRequest, _ completion: @escaping (_ response: [Badge]) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.getUserBadges, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(UserBedgesResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.badges.self)
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
    
    func serviceCallToGetReferralCode(request: BedgesAppRequest, _ completion: @escaping (_ response: TotalBedgesResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.GenerateReferralCode, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(TotalBedgesResponse.self, from: response!) // decode the response into model
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
    
    func serviceCallToGetUserNewBedges(request: BedgesAppRequest, _ completion: @escaping (_ response: [Badge]) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.getListNewBadges, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(UserBedgesResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.data.self)
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
    
    func serviceCallToGetUpdateUserNewBedges(request: BedgesUpdateRequest, _ completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.updateNewBadges, Loader: true, isMultipart: false) { (response) in
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
    
    func serviceCallToGetUpdateUserCoins(request: BedgesAppRequest, _ completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.BEDGES.updateRefereeCoinsFlag, Loader: true, isMultipart: false) { (response) in
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

