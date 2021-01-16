//
//  CategoriesViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController para representar el listado de categorías
class CategoriesViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
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
    
    let viewModel: CategoriesViewModel

    init(viewModel: CategoriesViewModel) {
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
    
    fileprivate func showErrorFetchingCategoriesAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    func hidenProgress() {
        progress.isHidden = true
    }

}

extension CategoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            return cell
        }

        fatalError()
    }
}

extension CategoriesViewController: CategoriesViewDelegate {
    func hidenProgressCatgory() {
        hidenProgress()
    }
    

    func categoriesFetched() {
        tableView.reloadData()
    }

    func errorFetchingCagegory() {
        self.showErrorFetchingCategoriesAlert()
    }
    
    
    
}
