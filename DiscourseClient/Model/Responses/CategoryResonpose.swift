//
//  CategoryResonpose.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation


struct CategoryResponse: Codable {
    var categoryList: CategoryList

    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

struct CategoryList: Codable {
    var categories: [Category]
}

struct Category: Codable {
    var name: String

}
