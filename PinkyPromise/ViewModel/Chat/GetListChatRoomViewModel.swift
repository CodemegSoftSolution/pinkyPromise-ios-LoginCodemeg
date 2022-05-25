//
//  GetListChatRoomViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 13/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


struct GetListChatRoomViewModel {
    
    func getChatRoomList(_ completion: @escaping (_ response: ChatRoomResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: [String: Any](), api: API.CHATROOM.getListChatRooms, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(ChatRoomResponse.self, from: response!) // decode the response into model
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
    
    func getUpdateUserRoom(request: UpdateUserChatRoomRequest, _ completion: @escaping (_ response: SuccessModel) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATROOM.UpdateUserChatRoom, Loader: true, isMultipart: false) { (response) in
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


