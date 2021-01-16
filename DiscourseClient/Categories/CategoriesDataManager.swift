//
//  CategoriesDataManager.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

/// Errores que pueden darse en el topics data manager
enum CategoriesDataManagerError: Error {
    case unknown
}

/// Data Manager con las opraciones necesarias de este módulo
protocol CategoriesDataManager {
    func fetchAllCategories(completion: @escaping (Result<CategoryResponse?, Error>) -> ())
}
