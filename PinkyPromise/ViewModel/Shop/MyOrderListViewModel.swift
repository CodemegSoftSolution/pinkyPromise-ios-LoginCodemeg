//
//  MyOrderListViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 23/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


protocol MyOrderListDelegate {
    var productList: Box<[OrderModel]> { get set }
    func getOrderProductList(request: MyOrderRequest)
    
    var success: Box<Bool> { get set }
    var paymentSuccess: Box<Bool> { get set }
}

struct MyOrderListViewModel: MyOrderListDelegate {
    var productList: Box<[OrderModel]> = Box([])
    
    var success: Box<Bool> = Box(Bool())
    var paymentSuccess: Box<Bool> = Box(Bool())
    
    func getOrderProductList(request: MyOrderRequest) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.SHOP.GetAllOrders, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(MyOrderListResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        self.productList.value = success.data
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
    
    func cancelOrder(request: [String:Any], completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request, api: API.SHOP.CancelOrder, Loader: true, isMultipart: false) { (response) in
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


