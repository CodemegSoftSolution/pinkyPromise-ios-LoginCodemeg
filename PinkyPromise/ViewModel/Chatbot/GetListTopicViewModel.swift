//
//  GetListTopicViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 06/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


protocol GetListTopicDelegate {
    func didRecieveGetListTopicResponse(response: GetListTopicResponse)
}

struct GetListTopicViewModel {
    var delegate: GetListTopicDelegate?
    
    func getTopicList(request: LanguageRequest) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATBOT.getTopicList, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(GetListTopicResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        self.delegate?.didRecieveGetListTopicResponse(response: success.self)
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





