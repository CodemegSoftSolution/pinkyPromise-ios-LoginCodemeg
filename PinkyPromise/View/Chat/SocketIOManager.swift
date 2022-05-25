//
//  SocketIOManager.swift
//  ChatWihSockets
//
//  Created by MACBOOK on 28/09/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    var socket: SocketIOClient!
    
    // defaultNamespaceSocket and swiftSocket both share a single connection to the server
    var manager = SocketManager(socketURL: URL(string: API.SOCKET_URL)!, config: [.log(false), .compress])
    
    override init() {
        super.init()
        socket = manager.defaultSocket
    }
    
    func reloadSocket()
    {
        manager = SocketManager(socketURL: URL(string: API.SOCKET_URL)!, config: [.log(false), .compress])
        socket = manager.defaultSocket
    }
    
    //Custom Connect with userID
    func connectSocket() {
        if AppModel.shared.currentUser == nil {
            return
        }
        
        if socket != nil {
            socket.disconnect()
        }
        
        self.socket.connect()
        
        //To connect socket
        socket.on(clientEvent: .connect) { (data, ack) in
            print("*********** socket connected **************",data,ack)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION.SUBSCRIBE_CHANNEL), object: nil)
        }
        
        //To connect socket
        socket.on(clientEvent: .disconnect) { (data, ack) in
            print("socket disconnected",data,ack)
        }

        socket.on(clientEvent: .error) {data, ack in
            print(data)
        }
    }
    
    func establishConnection() {
        reloadSocket()
        delay(0.1) {
            SocketIOManager.sharedInstance.connectSocket()
        }
    }
    
    func closeConnection() {
        socket.removeAllHandlers()
        socket.disconnect()
        print("socket Disconnected")
    }
    
    //MARK:- Send message
    func sendMessage(request: SendMessageRequest) {
        socket.emit("NEW_CHAT_MESSAGE", request.toJSON())
    }
    
    func joinChannel(_ dict : JoinChatRoomRequest) {
        socket.emit("JoinToChatRoom", dict.toJSON()) {
            log.success("Channel Subscribed with \(dict)")/
        }
    }
    
    func addLikeUnLikeMessage(request: ChatLikeUnlikeRequest) {
        socket.emit("UpdateLikeUnlike", request.toJSON())
    }
    
    //MARK:- getChatMessage
    func getChatMessage(completionHandler: @escaping (_ messageInfo: MessageListModel) -> Void) {
        socket.on("RECIVE_NEW_CHAT_MESSAGE") { (dataArray, socketAck) -> Void in
           // let messageJsonData = dataArray.first as! [String: Any]
            
            do {
                let data = try! JSONSerialization.data(withJSONObject: dataArray.first as! [String: Any])
                let success = try JSONDecoder().decode(MessageListModel.self, from: data) // decode the response into model
                completionHandler(success.self)
            }
            catch let err {
                log.error("ERROR OCCURED WHILE DECODING: \(Log.stats()) \(err)")/
            }
            
         //   completionHandler(messageJsonData)
        }
    }
    
    //MARK:- getChatMessage
    func getLikeUnLikeEventMessage(completionHandler: @escaping (_ messageInfo: LikeModel) -> Void) {
        socket.on("RECEIVE_LikeUnlikeUpdates") { (dataArray, socketAck) -> Void in
      //      let messageJsonData = dataArray.first as! [String: Any]
            do {
                let data = try! JSONSerialization.data(withJSONObject: dataArray.first as! [String: Any])
                let success = try JSONDecoder().decode(MessageLikeResponse.self, from: data) // decode the response into model
                switch success.status{
                case 200:
                    completionHandler(success.data.self ?? LikeModel.init())
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
    
    //MARK:- getChatMessage
    func getMessageCount(completionHandler: @escaping (_ messageInfo: [String : Any]) -> Void) {
        socket.on("update_count") { (dataArray, socketAck) -> Void in
            let messageJsonData = dataArray.first as! [String: Any]
            completionHandler(messageJsonData)
        }
    }
}

