//
//  UserCoordinator.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 13/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit


class UserCoordinator: Coordinator {
    let presenter: UINavigationController
    let userDataManager: UserDataManager
    let userDetailDataManger: UserDetailDataManager
    var userViewModel: UserViewModel?
    
    init(presenter: UINavigationController, userDataManger: UserDataManager, userDetailDataManager: UserDetailDataManager) {
        self.presenter = presenter
        self.userDataManager = userDataManger
        self.userDetailDataManger = userDetailDataManager
    }
    
    override func start() {
        let userViewModel = UserViewModel(userDataManager: userDataManager)
        let userViewController = UserViewController(viewModel: userViewModel)
        userViewController.title = NSLocalizedString("Usuarios", comment: "")
        userViewModel.viewDelegate = userViewController
        userViewModel.coordinatorDelegate = self
        self.userViewModel = userViewModel
        presenter.pushViewController(userViewController, animated: false)
    }
    
    override func finish() {}
}


extension UserCoordinator: UserCoordinatorDelegate {
    func didSelect(user: User) {
        guard let username = user.username  else { return }
        let userDetailViewModel = UserDetailViewModel(username: username, userDetailDataManager: userDetailDataManger)
        let userDetailViewController = UserDetailViewController(viewModel: userDetailViewModel)
        userDetailViewController.title = NSLocalizedString("Detalle Usuario", comment: "")
        userDetailViewModel.viewDelegate = userDetailViewController
        userDetailViewModel.coordinatorDelegate = self
        presenter.pushViewController(userDetailViewController, animated: false)
    }

}


extension UserCoordinator: UserDetailCoordinatorDelegate {
    func backButtonTapped() {
        presenter.popViewController(animated: true)
    }
}
