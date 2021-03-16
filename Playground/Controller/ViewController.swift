//
//  ViewController.swift
//  Playground
//
//  Created by Mobile 02 on 14/03/21.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailField.becomeFirstResponder()
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty,
              let pass = passwordField.text, !pass.isEmpty
        else { return }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pass, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                strongSelf.showCreateAccount(email: email, password: pass)
                return
            }
            
            print("logged in")
        })
        
        
    }
    
    func showCreateAccount(email: String, password: String){
        let alert = UIAlertController(title: "Create Account", message: "would you like to create an account", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                
                guard error == nil else {
                    print("Account creation failed")
                    return
                }
                
             
                print("signed in")
            })
        } ))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}

