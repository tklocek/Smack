//
//  Channel.swift
//  Smack
//
//  Created by Tomek Klocek on 2019-10-19.
//  Copyright © 2019 Tomek Klocek. All rights reserved.
//

import Foundation

//struct Channel : Decodable{
//    public private(set) var _id: String!
//    public private(set) var name: String!
//    public private(set) var description: String!
//    public private(set) var __v: Int?
//}

struct Channel : Decodable{
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}
