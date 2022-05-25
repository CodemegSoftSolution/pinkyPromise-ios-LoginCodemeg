//
//  GetMyChatRoomViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 12/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


protocol GetMyChatRoomDelegate {
 //   func didRecieveGetListChatRoomResponse(response: ChatMyRoomResponse)
    
    var success: Box<Bool> { get set }
    var chatRoomList: Box<[ChatMyRoomsInfoModel]> { get set }
    func getMyChatRoomList(request: MyChatRoomRequest)
}

struct GetMyChatRoomViewModel: GetMyChatRoomDelegate {
//    var delegate: GetMyChatRoomDelegate?
    
    var success: Box<Bool> = Box(Bool())
    var chatRoomList: Box<[ChatMyRoomsInfoModel]> = Box([])
    
    func getMyChatRoomList(request: MyChatRoomRequest) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATROOM.getMyChatRooms, Loader: false, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(ChatMyRoomResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        self.success.value = true
                        self.chatRoomList.value = success.chatRoomsInfo
       //                 self.delegate?.didRecieveGetListChatRoomResponse(response: success.self)
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
    
    func addLastMessage(channelRef: String, messageData: MessageListModel) {
        let index = chatRoomList.value.firstIndex { (data) -> Bool in
            data.chatRoomID == channelRef
        }
        if index != nil {
            self.chatRoomList.value[index!].latestMessage = messageData.text
            self.chatRoomList.value[index!].latestMessageID = messageData.id
            self.chatRoomList.value[index!].latestMsgTimestamp = messageData.timeStamp
            self.chatRoomList.value[index!].lastSeenMessageID = messageData.id
        }
    }
}


