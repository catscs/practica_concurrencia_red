//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Félix Luján Albarrán on 15/1/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCellViewModel {
    let user: User?
    var textLabelText: String?
    var imageView: UIImageView?
    
    init(user: User?) {
        self.user = user
    }
}

