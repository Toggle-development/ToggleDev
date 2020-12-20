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
    
    let user: AuthUser
    
    var body: some View {
        TabView{
            MainFeed()
                .tabItem {
                    Image(systemName: "house")
                }
                
               
               
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
               
            NotificationView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                }
                
            AccountView()
                .tabItem {
                    Image(systemName: "person.circle")
                }
        }
        .foregroundColor(.gray)
        .colorScheme(.dark).contrast(1.5).opacity(0.88)
        .accentColor(Color("tog"))
        
        
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
