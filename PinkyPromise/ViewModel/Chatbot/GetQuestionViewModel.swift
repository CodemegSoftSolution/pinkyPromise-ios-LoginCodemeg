//
//  GetQuestionViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 06/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

//protocol GetQuestionDelegate {
//    func didRecieveGetListQuestionResponse(response: GetListTopicResponse)
//}

struct GetQuestionViewModel {
//    var delegate: GetQuestionDelegate?
    
    func getQuestionList(basicQuestion: Bool, request: GetQuestionRequest,_ completion: @escaping (_ response: GetQestionResponse) -> Void) {
        var questionApi: String = String()
        if basicQuestion {
            questionApi = API.CHATBOT.getQuestion
        }
        else{
            questionApi = API.CHATBOT.getQuestion1
        }
        
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: questionApi, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(GetQestionResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
 //                       self.delegate?.didRecieveGetListQuestionResponse(response: success.self)
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
