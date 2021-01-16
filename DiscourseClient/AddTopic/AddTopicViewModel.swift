//
//  AddTopicViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate para comunicar aspectos relacionados con navegación
protocol AddTopicCoordinatorDelegate: class {
    func addTopicCancelButtonTapped()
    func topicSuccessfullyAdded()
}

/// Delegate para comunicar a la vista aspectos relacionados con UI
protocol AddTopicViewDelegate: class {
    func errorAddingTopic()
    func showProgress()
    func hidenProgress()
}

class AddTopicViewModel {
    weak var viewDelegate: AddTopicViewDelegate?
    weak var coordinatorDelegate: AddTopicCoordinatorDelegate?
    let dataManager: AddTopicDataManager

    init(dataManager: AddTopicDataManager) {
        self.dataManager = dataManager
    }

    func cancelButtonTapped() {
        coordinatorDelegate?.addTopicCancelButtonTapped()
    }

    func submitButtonTapped(title: String) {
        self.viewDelegate?.showProgress()
        dataManager.addTopic(title: title, raw: "Este es un topic de prueba para ver si funciona la api", createdAt: "May 20") { [weak self] (result) in
            switch result {
                case .success(_):
                    self?.viewDelegate?.hidenProgress()
                    self?.coordinatorDelegate?.topicSuccessfullyAdded()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.hidenProgress()
                    self?.viewDelegate?.errorAddingTopic()
            }
        }
    }
}
