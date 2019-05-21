//
//  UIVIewController.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit

extension UIViewController {

    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiate<T: UIViewController>(name storyboard: String) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: .main)
        let view = storyboard.instantiateViewController(withIdentifier: storyboardID) as! T
        return view
    }

}

extension UIViewController {

    func showAlert(title: String, message: String, okayButtonTitle: String, buttonAction: @escaping () -> Void ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: okayButtonTitle, style: .default) { (action) in
            buttonAction()
        })

        self.present(alertController, animated: true)
    }

}

