//
//  CategoryCell.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    var viewModel: CategoryCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.category.name
        }
    }
    
}
