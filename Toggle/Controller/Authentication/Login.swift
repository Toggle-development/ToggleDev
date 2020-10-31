//
//  authentication.swift
//  Toggle
//
//  Created by Walid Rafei on 10/30/20.
//

import Amplify
import AmplifyPlugins

class Login {
    
    /*
     @param: username (string)
     @param: password (String)
     */
    func signIn(username: String, password: String, completion: @escaping (String?) -> Void) {
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                print("Sign in succeeded")
                completion(nil)
            case .failure(let error):
                print("Sign in failed \(error)")
                completion(error.errorDescription)
            }
        }
    }
}

