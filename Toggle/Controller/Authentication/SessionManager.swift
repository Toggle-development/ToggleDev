//
//  SessionManager.swift
//  Toggle
//
//  Created by Walid Rafei on 10/31/20.
//

import SwiftUI
import Amplify
import AmplifyPlugins

final class SessionManager: ObservableObject {
    enum AuthState {
        case signUp
        case login
        case confirmCode(username: String, password: String)
        case session(user: AuthUser)
    }
    
    @Published var authState: AuthState = .login
    
    func getCurrentAuthUser() {
        if let user = Amplify.Auth.getCurrentUser() {
            withAnimation {
                authState = .session(user: user)
            }
        } else {
            withAnimation {
                authState = .login
            }
        }
    }
    
    func showSignUp() {
        withAnimation {
            authState = .signUp
        }
    }
    
    func showLogin() {
        withAnimation {
            authState = .login
        }
    }
    
    //MARK: - Sign Up
    /*
     @param: username (string)
     @param: password (string)
     @param: email (string)
     */
    func signUp(username: String, password: String, email: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) {[weak self] result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    DispatchQueue.main.async {
                        withAnimation {
                            self?.authState = .confirmCode(username: username, password: password)
                        }
                    }
                } else {
                    self?.signIn(username: username, password: password)
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    /*
     @param: username (string)
     @param: confirmationCode (string)
     */
    func confirmSignUp(for username: String, with confirmationCode: String, password: String) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) {[weak self] result in
            switch result {
            case .success(let result):
                if result.isSignupComplete {
                    DispatchQueue.main.async {
                        self?.signIn(username: username, password: password)
                    }
                }
                print("Confirm signUp succeeded")
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
            }
        }
    }
    
    /*
     @param: username
     paramenter used to determine which user to send verification code to.
     */
    func resendSignUpConfirmationCode(username: String) {
        Amplify.Auth.resendSignUpCode(for: username) { result in
            switch result {
            case .success(let result):
                print("Delivery details \(result.destination)")
            case .failure(_):
                print("Error re-sending sign up confirmation code")
            }
        }
    }
    
    //MARK: - Sign In
    
    /*
     @param: username (string)
     @param: password (String)
     */
    func signIn(username: String, password: String) {
        Amplify.Auth.signIn(username: username, password: password) {[weak self] result in
            switch result {
            case .success(let result):
                if result.isSignedIn {
                    print("Sign in succeeded")
                    DispatchQueue.main.async {
                        self?.getCurrentAuthUser()
                    }
                } else {
                    switch result.nextStep {
                    case .confirmSignUp(.some(_)):
                        DispatchQueue.main.async {
                            withAnimation {
                                self?.authState = .confirmCode(username: username, password:password)
                            }
                        }
                    case .confirmSignInWithSMSMFACode(_, _):
                        print("confirm Sign In with SMSMFA Code")
                    case .confirmSignInWithCustomChallenge(_):
                        print("confirm Sign In with custom challenge")
                    case .confirmSignInWithNewPassword(_):
                        print("confirm sign IN with new password")
                    case .resetPassword(_):
                        print("reset password")
                    case .done:
                        print("sign in done")
                    case .confirmSignUp(.none):
                        print("confirmSignUp none")
                        DispatchQueue.main.async {
                            withAnimation {
                                self?.authState = .confirmCode(username: username, password: password)
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Sign in failed \(error)")
            }
        }
    }
    
    //MARK: - Sign Out
    
    /*
     * sign out from the current device only
     */
    func signOutLocally() {
        Amplify.Auth.signOut() {[weak self] result in
            switch result {
            case .success:
                print("Successfully signed out")
                DispatchQueue.main.async {
                    self?.getCurrentAuthUser()
                }
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    /*
     * sign out from all devices associated with current user session (not using currently)
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
