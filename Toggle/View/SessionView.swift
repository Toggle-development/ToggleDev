//
//  SessionView.swift
//  Toggle
//
//  Created by Walid Rafei on 10/31/20.
//

import SwiftUI
import Amplify
import UIKit
import AVKit

struct SessionView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var presentError: Bool = false
    @State private var errorMessage: String = ""
    @State var view = 0
    let user: AuthUser
    
    var body: some View {
        VStack{
            TopNav().ignoresSafeArea()                  /*Button(action: {
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
                }*/
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<10) {
                        Text("Item \($0)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: 200, height: 200)
                            .background(Color.red)
                    }
                }
            }
            .zIndex(-1)
            .scaleEffect(1.8)
            
            BottomNav(view: self.$view)
        }
        .edgesIgnoringSafeArea(.bottom)
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

