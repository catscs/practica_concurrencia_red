//
//  UserResponse.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation


struct UserResponse: Codable {
    let directoryItems: [DirectoryItem]?

    enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
    }
}

struct DirectoryItem: Codable {
    let user: User?
}


struct User: Codable {
    let id: Int?
    let username, avatarTemplate, name: String?
    var canEdit: Bool?

    enum CodingKeys: String, CodingKey {
        case id, username
        case avatarTemplate = "avatar_template"
        case name
        case canEdit = "can_edit"
    }
}

