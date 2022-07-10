//
//  UIViewController+Extensions.swift
//  RickAndMorty
//
//  Created by Ekaterina Nedelko on 10.07.22.
//

import UIKit
import ProgressHUD

// MARK: - ProgressHUD

extension UIViewController {
    
    func startLoading() {
        ProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        ProgressHUD.dismiss()
        self.view.isUserInteractionEnabled = true
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
    }
}

// MARK: - DefaultAlert

extension UIViewController {
    
    func presentDefaultAlert(title: String,
                             message: String,
                             buttonTitle: String?,
                             buttonAction: (() -> ())?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            alert.dismiss(animated: true, completion: buttonAction)
        }
        alert.addAction(action)
        
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
