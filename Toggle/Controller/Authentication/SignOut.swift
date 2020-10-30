//
//  SignOut.swift
//  Toggle
//
//  Created by Walid Rafei on 10/30/20.
//

import Foundation
import Amplify
import AmplifyPlugins

class SignOut {
    
    /*
     * sign out from the current device only
     */
    func signOutLocally() {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    /*
     * sign out from all devices associated with current user session
     */
    func signOutGlobally() {
        Amplify.Auth.signOut(options: .init(globalSignOut: true)) { result in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
}
