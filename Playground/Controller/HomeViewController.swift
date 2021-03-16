//
//  HomeViewController.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import UIKit

class HomeViewController: UIViewController {

    var auth = AuthManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        auth.signOut { result in
            switch result {
            case .Success(_): self.goToSignIn()
            case .Failure(let error): self.showError(error: error)
            }
        }
    }
    
    func goToSignIn(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func showError(error: Error){
        
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
