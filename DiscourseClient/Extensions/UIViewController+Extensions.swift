//
//  UIViewController+Extensions.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Muestra un alertcontroller con una única acción
    /// - Parameters:
    ///   - alertMessage: Mensaje del alert
    ///   - alertTitle: Título del alert
    ///   - alertActionTitle: Título de la acción
    func showAlert(_ alertMessage: String,
                               _ alertTitle: String = NSLocalizedString("Error", comment: ""),
                               _ alertActionTitle: String = NSLocalizedString("OK", comment: "")) {

        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension String {
    func createUrlImage(size: String, comletion: (URL) -> Void) {
        let urlRemplace = self.replacingOccurrences(of: "{size}", with: size, options: .literal, range: nil)
        guard let url = URL(string: "https://mdiscourse.keepcoding.io\(urlRemplace)") else { return }
        comletion(url)
    }
    
}

extension UIImageView {
    func imageFromURL(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
