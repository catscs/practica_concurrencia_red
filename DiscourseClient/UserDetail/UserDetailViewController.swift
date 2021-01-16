//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    lazy var labelID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelSurname: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .line
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .black
        tf.keyboardAppearance = .dark
        return tf
    }()
    
    
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return button
    }()
    

    lazy var idStackView: UIStackView = {
        let labelUserIDTitle = UILabel()
        labelUserIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserIDTitle.text = NSLocalizedString("ID: ", comment: "")
        labelUserIDTitle.textColor = .black

        let userIDStackView = UIStackView(arrangedSubviews: [labelUserIDTitle, labelID])
        userIDStackView.translatesAutoresizingMaskIntoConstraints = false
        userIDStackView.axis = .horizontal

        return userIDStackView
    }()

    lazy var surnameStackView: UIStackView = {
        let labelUserTitleTitle = UILabel()
        labelUserTitleTitle.text = NSLocalizedString("surname: ", comment: "")
        labelUserTitleTitle.translatesAutoresizingMaskIntoConstraints = false

        let userNameStackView = UIStackView(arrangedSubviews: [labelUserTitleTitle, labelSurname])
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.axis = .horizontal

        return userNameStackView
    }()
    
    lazy var nameStackView: UIStackView = {
        let labelUserTitleTitle = UILabel()
        labelUserTitleTitle.text = NSLocalizedString("Name: ", comment: "")
        labelUserTitleTitle.translatesAutoresizingMaskIntoConstraints = false

        let userNameStackView = UIStackView(arrangedSubviews: [labelUserTitleTitle, labelName])
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.axis = .horizontal

        return userNameStackView
    }()
    
    lazy var nameFieldStackView: UIStackView = {
        let labelUserTitleTitle = UILabel()
        labelUserTitleTitle.text = NSLocalizedString("Name: ", comment: "")
        labelUserTitleTitle.translatesAutoresizingMaskIntoConstraints = false

        let userNameStackView = UIStackView(arrangedSubviews: [labelUserTitleTitle, nameTextField])
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.axis = .vertical

        return userNameStackView
    }()
    
    lazy var progress: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView(style: .large)
        progress.center = view.center
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.startAnimating()
        return progress
    }()
    
    
    
    let viewModel: UserDetailViewModel

    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(idStackView)
        NSLayoutConstraint.activate([
            idStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            idStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(surnameStackView)
        NSLayoutConstraint.activate([
            surnameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            surnameStackView.topAnchor.constraint(equalTo: idStackView.bottomAnchor, constant: 8)
        ])
                
        view.addSubview(nameStackView)
        NSLayoutConstraint.activate([
            nameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameStackView.topAnchor.constraint(equalTo: surnameStackView.bottomAnchor, constant: 8)
        ])
        
        
        view.addSubview(nameFieldStackView)
        NSLayoutConstraint.activate([
            nameFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameFieldStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            nameFieldStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 8)
        ])
        
        
        view.addSubview(updateButton)
        NSLayoutConstraint.activate([
            updateButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            updateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            updateButton.topAnchor.constraint(equalTo: nameFieldStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(progress)
        NSLayoutConstraint.activate([
            progress.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            progress.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ])
        
        
        nameFieldStackView.isHidden = true
        updateButton.isHidden = true

        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    @objc func updateButtonTapped() {
        viewModel.updateUser(name: nameTextField.text ?? "")
    }
    
    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    fileprivate func showErrorFetchingUserDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showSuccessFetchingUserDetailAlert() {
        let alertMessage: String = NSLocalizedString("Nombre cambiado correctamente", comment: "")
        showAlert(alertMessage, "Success")
    }
    
    func updateUI() {
        labelID.text = viewModel.labelUserIDText
        labelSurname.text = viewModel.labelUserNameText
        labelName.text = viewModel.labelNameText
        nameTextField.text = viewModel.labelNameText
    }
    
    func showField() {
        nameFieldStackView.isHidden = false
        updateButton.isHidden = false
        nameStackView.isHidden = true
    }
    
    func hidenProgressView() {
        progress.isHidden = true
    }
    
    func showProgressView() {
        progress.isHidden = false
    }

}

extension UserDetailViewController: UserDetailViewDelegate {
    func showProgress() {
        showProgressView()
    }
    
    func hidenProgress() {
        hidenProgressView()
    }
    
    func successUpdateUser() {
        showSuccessFetchingUserDetailAlert()
    }
    
    func userDetailFetched() {
        updateUI()
    }
    
    func errorFetchingUserDetail() {
        showErrorFetchingUserDetailAlert()
    }
    
    func showFields() {
        showField()
    }
    
   
}
    
