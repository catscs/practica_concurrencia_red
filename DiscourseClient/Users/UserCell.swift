//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.user?.username
            imageView?.image = UIImage(named: "no-image")
            viewModel.user?.avatarTemplate?.createUrlImage(size: "100", comletion: { url in
                imageView?.imageFromURL(url: url)
            })
        }
    }
    
}
