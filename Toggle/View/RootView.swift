//
//  RootView.swift
//  Toggle
//
//  Created by Walid Rafei on 11/1/20.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var sessionManager: SessionManager

    @ViewBuilder
    var body: some View {
        switch sessionManager.authState {
        case .login:
            LoginView().transition(.asymmetric(insertion: .slide, removal: .opacity)).environmentObject(sessionManager)

        case .signUp:
            SignUpView().transition(.asymmetric(insertion: .slide, removal: .opacity)).environmentObject(sessionManager)

        case .confirmCode(let username, let password):
            ConfirmationView(username: username, password: password).transition(.asymmetric(insertion: .slide, removal: .opacity)).environmentObject(sessionManager)
            
        case .session(let user):
            SessionView(user: user).transition(.asymmetric(insertion: .slide, removal: .opacity)).environmentObject(sessionManager)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
