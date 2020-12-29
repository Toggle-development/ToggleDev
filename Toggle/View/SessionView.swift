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
    }
}

struct SessionView_Previews: PreviewProvider {
    @Binding var dummy: Bool
    struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummy"
    }
    static var previews: some View {
        SessionView(user: DummyUser()).environmentObject(SessionManager())
    }
}
