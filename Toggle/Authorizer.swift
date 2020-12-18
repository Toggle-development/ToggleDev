//
//  Authorizer.swift
//  Toggle
//
//  Created by James McDougall on 12/17/20.
//

import Foundation
import Amplify

class Authorizer {
    
    enum ToggleAuthError: Error {
        case FailedSignIn
    }
    
    func signUp(username: String, password: String, email: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    func confirmSignUp(for username: String, with confirmationCode: String) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
            }
        }
    }
    
    func signIn(username: String, password: String) throws {
        var e: Bool = false
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                print("Sign in succeeded")
                print("About to upload test data.")
                Database().uploadTestData()
            case .failure(let error):
                print("Sign in failed \(error)")
                e = true
            }
        }
        if (e) {
            throw ToggleAuthError.FailedSignIn
        }
    }
    
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

    
    func signedIn(username: String) -> Bool {
        var e: Bool = false
        _ = Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success:
                e = false
            case .failure:
                e = true
            }
        }
        return e == false
    }
}
