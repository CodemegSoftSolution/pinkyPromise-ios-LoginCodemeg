//
//  GetProductViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 18/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

protocol GetAllProductDelegate {
    var productList: Box<[ProductListModel]> { get set }
    func getAllProductList(request: ShopLanguageRequest)
}

struct GetAllProductViewModel: GetAllProductDelegate {
    var productList: Box<[ProductListModel]> = Box([])
    
    func getAllProductList(request: ShopLanguageRequest) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.SHOP.GetAllProducts, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(AllProductListResponse.self, from: response!) // decode the response into model
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
}


