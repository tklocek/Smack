//
//  MessageSerisce.swift
//  Smack
//
//  Created by Tomek Klocek on 2019-10-19.
//  Copyright © 2019 Tomek Klocek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var unreadChannels = [String]()
    var selectedChannel : Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
               
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error {
//                    debugPrint(error as Any)
//                                    }
//                print(self.channels)
                
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel)
                        }
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                        completion(true)
                    }
                } catch {
                   print(error)
                   completion(false)
                }
      
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func findAllMessageForChannel(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
                
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                
                do {
                    if let json = try JSON(data : data).array {
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId "].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let avatarName = item["userAvatar"].stringValue
                            let avatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: avatarName, userAvatarColor: avatarColor, id: id, timeStamp: timeStamp)
                            self.messages.append(message)
                        }
                        completion(true)
                    
                } else {
                    debugPrint(response.result.error as Any)
                    completion(false)
                }
            } catch {
                print(error)
                completion(false)
            }
                
                
        }
        
        
    }
        
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
}
