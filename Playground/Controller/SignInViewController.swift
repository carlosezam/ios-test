//
//  SignInViewController.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    let autmgr = AuthManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        if autmgr.isSigned() {
            goToHome()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty,
              let pass = passField.text, !pass.isEmpty
        else { return }
        
        autmgr.signIn(email: email, password: pass ){ result in
            switch result {
            case .Success(_): self.goToHome()
            case .Failure(let error): self.showError(error)
            }
        }
        
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty,
              let pass = passField.text, !pass.isEmpty
        else { return }
        
        autmgr.signUp(email: email, password: pass ){ result in
            switch result {
            case .Success(_): self.goToHome()
            case .Failure(let error): self.showError(error)
            }
        }
    }
    
    func goToHome() {
        performSegue(withIdentifier: K.Segue.SignInToHome, sender: self )
    }
    
    func showError(_ error: Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "title", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
