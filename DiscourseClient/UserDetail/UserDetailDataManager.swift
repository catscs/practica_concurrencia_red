//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailDataManager: class {
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ())
    func updateUser(name: String, username: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ())
}
