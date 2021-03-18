//
//  SignInViewController.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import UIKit
import Firebase



class SignInViewController: CustomViewController {
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
        emailField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        emailField.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty,
              let pass = passField.text, !pass.isEmpty
        else { return }
        showLoadingAlert()
        autmgr.signIn(email: email, password: pass ){ result in
            self.dismisLoadingAlert()
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
        showLoadingAlert()
        autmgr.signUp(email: email, password: pass ){ result in
            self.dismisLoadingAlert()
            switch result {
            case .Success(_): self.goToHome()
            case .Failure(let error): self.showError(error)
            }
        }
    }
    
    func goToHome() {
        performSegue(withIdentifier: K.Segue.SignInToHome, sender: self )
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
