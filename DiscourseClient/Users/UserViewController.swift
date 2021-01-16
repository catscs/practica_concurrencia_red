//
//  UserViewController.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 13/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    lazy var progress: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView(style: .large)
        progress.center = view.center
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.startAnimating()
        return progress
    }()
    
    
    
    let viewModel: UserViewModel
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(progress)
        NSLayoutConstraint.activate([
            progress.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            progress.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    fileprivate func showErrorFetchingUserAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    func hidenProgressView() {
        progress.isHidden = true
    }
    
    func showProgressView() {
        progress.isHidden = false
    }
}

extension UserViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            return cell
        }

        fatalError()
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension UserViewController: UserViewDelegate {
  
    func userFetched() {
        tableView.reloadData()
    }

    func errorFetchingUser() {
        self.showErrorFetchingUserAlert()
    }
    
    func showProgress() {
        showProgressView()
    }
    
    func hidenProgress() {
        hidenProgressView()
    }
    
}
