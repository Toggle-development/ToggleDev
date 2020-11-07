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
        VStack(spacing: 0){
            TopNav().padding(.bottom, 10)
            switch self.view{
                case 0:
                    MainFeed()
                case 1:
                    SearchView()
                case 2 :
                    MainFeed()
                case 3:
                    AccountView()
                default:
                    MainFeed()
            
            }
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

//MARK: - Sign out might need later
/*Button(action: {
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
