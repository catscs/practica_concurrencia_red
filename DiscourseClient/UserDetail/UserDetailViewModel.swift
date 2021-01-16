//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailCoordinatorDelegate: class {
    func backButtonTapped()
}

protocol UserDetailViewDelegate: class {
    func userDetailFetched()
    func errorFetchingUserDetail()
    func successUpdateUser()
    func showFields()
    func showProgress()
    func hidenProgress()
}

class UserDetailViewModel {
    var labelUserIDText: String?
    var labelNameText: String?
    var labelUserNameText: String?
    
    weak var viewDelegate: UserDetailViewDelegate?
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    let userDetailDataManager: UserDetailDataManager
    let username: String

    init(username: String, userDetailDataManager: UserDetailDataManager) {
        self.username = username
        self.userDetailDataManager = userDetailDataManager
    }
    
    func viewDidLoad() {
        self.viewDelegate?.showProgress()
        userDetailDataManager.fetchUser(username: username) { [weak self] (result) in
            switch result {
                case .success(let responseUser):
                    self?.viewDelegate?.hidenProgress()
                    guard let user = responseUser?.user else {return}
                    self?.labelUserIDText = "\(user.id ?? 0)"
                    self?.labelNameText = user.name
                    self?.labelUserNameText = user.username
                    if user.canEdit ?? false {
                        self?.viewDelegate?.showFields()
                    }
                    self?.viewDelegate?.userDetailFetched()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.hidenProgress()
                    self?.viewDelegate?.errorFetchingUserDetail()
            }
        }
        
    }
    
    func updateUser(name: String?) {
        guard let nameUpdate = name else { return }
        self.viewDelegate?.showProgress()
        userDetailDataManager.updateUser(name: nameUpdate, username: username) { [weak self] (result) in
            switch result {
                case .success:
                    self?.viewDelegate?.hidenProgress()
                    self?.viewDelegate?.successUpdateUser()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.hidenProgress()
                    self?.viewDelegate?.errorFetchingUserDetail()
            }
        }
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.backButtonTapped()
    }
}
