//
//  SocketService.swift
//  Smack
//
//  Created by Tomek Klocek on 2019-10-22.
//  Copyright © 2019 Tomek Klocek. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    let manager : SocketManager
    let socket : SocketIOClient

    override init() {
        self.manager = SocketManager(socketURL: URL(string: URL_GET_CHANNELS)!)
        self.socket = manager.defaultSocket
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        print("GetChannel function starts")
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            print("GetChannel function - success")
            completion(true)
        }
        socket.on(clientEvent: .connect) {data, ack in
                print("socket connected")
        }
        socket.on("channelCreated") { dataArray, ack in
            print("success")
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        
    }
    
    
    func getChatMessage(completion: @escaping CompletionHandler) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else {return}
            guard let channelId  = dataArray[2] as? String else {return}
            guard let userName  = dataArray[3] as? String else {return}
            guard let userAvatar  = dataArray[4] as? String else {return}
            guard let userAvatarColor  = dataArray[5] as? String else {return}
            guard let id  = dataArray[6] as? String else {return}
            guard let timeStamp  = dataArray[7] as? String else {return}
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                
                let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
            
        }
         
    }
    
}
