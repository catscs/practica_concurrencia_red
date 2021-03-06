//
//  SingleTopicRequest.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 17/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

// TODO: Implementar las propiedades de esta request
struct SingleTopicRequest: APIRequest {
    
    typealias Response = SingleTopicResponse
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var method: Method = .GET
    
    var path: String {
        return "/t/\(self.id).json"
    }
    
    var parameters: [String : String]  = [:]
    
    var body: [String : Any] = [:]
    
    var headers: [String : String] = [:]
}
