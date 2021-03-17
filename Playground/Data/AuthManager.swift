//
//  AuthManager.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import Foundation
import Firebase


enum AuthManagerResult<T> {
  case Success(T)
  case Failure(Error)
}

class AuthManager {
    private let auth: Auth

    
    init(){
        auth = Auth.auth()
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<String>) -> Void ){
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                completion( .Failure(error))
            } else {
                completion( .Success(email) )
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<String>) -> Void){
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                completion( .Failure(error))
            } else {
                completion( .Success(email) )
            }
        }
    }
    
    func signOut( completion: (Result<String>) -> Void ){
        do{
            try auth.signOut()
            completion( .Success("") )
        } catch let signOutError as NSError {
            completion( .Failure(signOutError) )
        }
    }
    
    func isSigned() -> Bool {
        return auth.currentUser != nil
    }
}
