//
//  CustomViewController.swift
//  Playground
//
//  Created by Mobile 02 on 17/03/21.
//

import Foundation
import UIKit

class CustomViewController: UIViewController {
    
    var loadingAlert: UIAlertController?
    
    func showLoadingAlert(){
        loadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        loadingAlert!.view.addSubview(loadingIndicator)
        present(loadingAlert!, animated: true, completion: nil)
        
    }
    
    func dismisLoadingAlert(){
        DispatchQueue.main.async {
            self.loadingAlert?.dismiss(animated: false, completion: nil)
        }
    }
}
