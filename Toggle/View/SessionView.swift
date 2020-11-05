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
    @State private var presentError: Bool = false
    @State private var errorMessage: String = ""
    
    let user: AuthUser
    
    var body: some View {
        Button(action: {
            sessionManager.signOutLocally()
        }) {
            Text("Sign Out")
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("signout-locally-error")), perform: { (errorMsg) in
            if let userInfo = errorMsg.userInfo, let errMsg = userInfo["errorMessage"] {
                self.presentError.toggle()
                if let errString = errMsg as? String {
                    self.errorMessage = errString
                }
           }
        }).alert(isPresented: $presentError) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
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
