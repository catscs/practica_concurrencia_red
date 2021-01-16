//
//  DeleteTopicRequest.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation


struct DeleteTopicRequest: APIRequest {
    
    typealias Response = DeleteTopicResponse
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var method: Method {
        return .DELETE
    }
    
    var path: String {
        return "/t/\(self.id).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
