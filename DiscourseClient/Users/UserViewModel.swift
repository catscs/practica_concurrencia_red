//
//  UserViewModel.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 13/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserCoordinatorDelegate: class {
    func didSelect(user: User)
}

protocol UserViewDelegate: class {
    func userFetched()
    func errorFetchingUser()
    func showProgress()
    func hidenProgress()
}

class UserViewModel {
    weak var coordinatorDelegate: UserCoordinatorDelegate?
    weak var viewDelegate: UserViewDelegate?
    let userDataManager: UserDataManager
    var userViewModels: [UserCellViewModel] = []
    
    init(userDataManager: UserDataManager) {
        self.userDataManager = userDataManager
    }
    
    func viewWasLoaded() {
        self.viewDelegate?.showProgress()
        userDataManager.fetchAllUsers { [weak self] (result) in
            switch result {
                case .success(let userResponse):
                    self?.viewDelegate?.hidenProgress()
                    guard let directoryItems = userResponse?.directoryItems else { return }
                    self?.userViewModels = directoryItems.map({ items -> UserCellViewModel in
                        return UserCellViewModel(user: items.user)
                    })
                    self?.viewDelegate?.userFetched()
                   
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.hidenProgress()
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return userViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userViewModels.count else { return nil }
        return userViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < userViewModels.count else { return }
        guard let user =  userViewModels[indexPath.row].user else { return }
        self.coordinatorDelegate?.didSelect(user: user)
    }
}
