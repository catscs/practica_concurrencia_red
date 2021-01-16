//
//  UserDataManager.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation


enum UserDataManagerError: Error {
    case unknown
}

protocol UserDataManager {
    func fetchAllUsers(completion: @escaping (Result<UserResponse?, Error>) -> ())
}
