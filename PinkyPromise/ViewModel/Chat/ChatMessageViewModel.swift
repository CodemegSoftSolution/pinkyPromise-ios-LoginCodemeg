//
//  ChatMessageViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 16/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


protocol MessageListDelegate {
    func didRecieveMessageListResponse(response: MessageListResponse)
//    func didRecieveChatLIkeUnlikeResponse(response: MessageLikeResponse)
    func didRecieveUpdateChatRoomResponse(response: SuccessModel)
}

struct ChatMessageViewModel {
    var delegate: MessageListDelegate?
    
    func getMessageList(request: MyChatMessageRequest) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATROOM.getMessages, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(MessageListResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        self.delegate?.didRecieveMessageListResponse(response: success.self)
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
    
    
    func updateChatRoomActivity(request: UpdateChatRoomRequest) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATROOM.UpdateChatRoomActivity, Loader: false, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(SuccessModel.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        self.delegate?.didRecieveUpdateChatRoomResponse(response: success.self)
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
    
    
//    func chatRoomLikeUnlike(request: ChatLikeUnlikeRequest) {
//        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATROOM.ChatroomsLikeUnlikeCapture, Loader: false, isMultipart: false) { (response) in
//            if response != nil{                             //if response is not empty
//                do {
//                    let success = try JSONDecoder().decode(MessageLikeResponse.self, from: response!) // decode the response into model
//                    switch success.status {
//                    case 200:
//                        self.delegate?.didRecieveChatLIkeUnlikeResponse(response: success.self)
//                        break
//                    default:
//                        log.error("\(Log.stats()) \(success.message)")/
//                    }
//                }
//                catch let err {
//                    log.error("ERROR OCCURED WHILE DECODING: \(Log.stats()) \(err)")/
//                }
//            }
//        }
//    }
    
}


