//
//  ContentView.swift
//  Toggle
//
//  Created by user185695 on 10/27/20.
//

import Foundation
import SwiftUI
import Amplify

struct ContentView: View {
    
    func performOnAppear() {
        let authorizer = Authorizer()
        //authorizer.signOutLocally()
        //authorizer.signOutGlobally()
        do {
            try authorizer.signIn(username:"jamesy", password:"toggle12345")
            print("Signed jamesy in.")
        } catch  {
            print("Failed to sign user in.")
            exit(1)
        }
    }
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                self.performOnAppear()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
