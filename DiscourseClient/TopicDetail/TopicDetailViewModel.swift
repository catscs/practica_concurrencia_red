//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
    func backTopicDelete()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func showButtonDeleteTopic()
    func showProgress()
    func hidenProgress()
}

class TopicDetailViewModel {
    var labelTopicIDText: String?
    var labelTopicNameText: String?

    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }

    func viewDidLoad() {
        self.viewDelegate?.showProgress()
        topicDetailDataManager.fetchTopic(id: topicID) { [weak self] (result) in
            switch result {
                case .success(let topicResponse):
                    self?.viewDelegate?.hidenProgress()
                    self?.labelTopicIDText = String(topicResponse?.id ?? 0)
                    self?.labelTopicNameText = topicResponse?.title
                    self?.viewDelegate?.topicDetailFetched()
                    guard let _ = topicResponse?.details?.canEdit else { return }
                    self?.viewDelegate?.showButtonDeleteTopic()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.hidenProgress()
                    self?.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }
    
    func deleteTopicButtonTapped() {
        self.viewDelegate?.showProgress()
        topicDetailDataManager.deleteTopic(id: topicID) { [weak self] (result) in
            switch result {
                case .success(_):
                    self?.viewDelegate?.hidenProgress()
                    self?.coordinatorDelegate?.backTopicDelete()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.hidenProgress()
                    self?.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }

    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }
}
