//
//  UpdateUserRequest.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 16/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct UpdateUserRequest : APIRequest {
    
    typealias Response = SingleUserResponse
    
    let username: String
    let name: String
    
    init(username: String, name: String) {
        self.username = username
        self.name = name
    }
    
    var method: Method = .PUT
    
    var path: String {
        return "/users/\(username).json"
    }
    
    var parameters: [String : String] = [:]
    
    var body: [String : Any] {
        return ["name": name]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
