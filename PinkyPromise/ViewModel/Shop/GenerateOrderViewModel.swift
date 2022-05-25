//
//  GenerateOrderViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 21/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


struct GenerateOrderViewModel {
    func getAllProductList(request: GenerateOrderRequest, completion: @escaping (_ response: GenerateOrderResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.SHOP.GenerateOrder, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(GenerateOrderResponse.self, from: response!) // decode the response into model
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
    
    func paymentConfirmation(request: PaymentOrderRequest, completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.SHOP.PaymentConfirmation, Loader: true, isMultipart: false) { (response) in
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
    
    func applyCoupon(request: ApplyCouponRequest, completion: @escaping (_ response: ApplyCouponResponse) -> Void) {
        APIManager.sharedInstance.post_Service_Call(params: request.toJSON(), api: API.SHOP.ApplyPromoCode, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(ApplyCouponResponse.self, from: response!) // decode the response into model
                    completion(success.self)
                }
                catch let err {
                    log.error("ERROR OCCURED WHILE DECODING: \(Log.stats()) \(err)")/
                }
            }
        }
    }
}
