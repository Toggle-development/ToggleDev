//
//  SessionView.swift
//  Toggle
//
//  Created by Walid Rafei on 10/31/20.
//

import SwiftUI
import Amplify

struct SessionView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    let user: AuthUser
    
    var body: some View {
        Button(action: {
            sessionManager.signOutLocally()
        }) {
            Text("Sign Out")
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummy"
    }
    static var previews: some View {
        SessionView(user: DummyUser()).environmentObject(SessionManager())
    }
}
