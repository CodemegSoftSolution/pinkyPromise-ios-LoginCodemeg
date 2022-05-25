//
//  GetChatUnReadCountViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 19/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


protocol GetChatUnReadCountDelegate {
    var success: Box<Bool> { get set }
    var getChatCountInfo: Box<Int> { get set }
    func getChatCount(request: MyChatRoomRequest)
}

struct GetChatUnReadCountViewModel: GetChatUnReadCountDelegate {
    var success: Box<Bool> = Box(Bool())
    var getChatCountInfo: Box<Int> = Box(Int())
    
    func getChatCount(request: MyChatRoomRequest) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATROOM.getChatRoomsUnreadMsgCount, Loader: false, isMultipart: false) { (response) in
            if response != nil{
                do {
                    let success = try JSONDecoder().decode(CountResponse.self, from: response!) // decode the response into success model
                    switch success.status {
                    case 200:
                        self.getChatCountInfo.value = success.unreadMsgCount
                        self.success.value = true
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


