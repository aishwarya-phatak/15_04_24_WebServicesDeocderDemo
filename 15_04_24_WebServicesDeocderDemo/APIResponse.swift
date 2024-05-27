//
//  APIResponse.swift
//  15_04_24_WebServicesDeocderDemo
//
//  Created by Vishal Jagtap on 27/05/24.
//

import Foundation
struct APIResponse : Decodable{
    var posts : [Post]
}

struct Post : Decodable{
    var id : Int
    var title : String
    var body : String
    var tags : [String]
    var reactions : Reaction
    var views : Int
    var userId : Int
}

struct Reaction : Decodable{
    var likes : Int
    var dislikes : Int
}
