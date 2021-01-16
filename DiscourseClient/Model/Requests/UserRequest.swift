//
//  UserRequest.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct UserRequest : APIRequest {
    
    typealias Response = UserResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/directory_items.json"
    }
    
    var parameters: [String : String] = ["period":"weekly", "order":"likes_received"]
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
