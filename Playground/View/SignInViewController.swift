//
//  SignInViewController.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import UIKit
import Firebase

protocol SignInView {
    var email: String {get set}
}

class SignInViewController: UIViewController, SignInView {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    var email: String {
        get {
            emailField.text ?? ""
        }
        set {
            emailField.text = newValue
        }
    }
    
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
        // Do any additional setup after loading the view.
    }
    
    var alert: UIAlertController?
    
    func loading(){
        alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert!.view.addSubview(loadingIndicator)
        present(alert!, animated: true, completion: nil)
        
    }
    func ending(){
        alert?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty,
              let pass = passField.text, !pass.isEmpty
        else { return }
        loading()
        autmgr.signIn(email: email, password: pass ){ result in
            self.ending()
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
