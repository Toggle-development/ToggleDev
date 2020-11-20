//
//  ContentView.swift
//  Toggle
//
//  Created by user185695 on 10/27/20.
//

import Foundation
import SwiftUI
import Amplify

func signIn(username: String, password: String) {
    Amplify.Auth.signIn(username: username, password: password) { result in
        switch result {
        case .success:
            print("Sign in succeeded")
        case .failure(let error):
            print("Sign in failed \(error)")
        }
    }
}

struct ContentView: View {
    
    func performOnAppear() {
        signIn("james", "12345")
        let dataHandle = Database()
        dataHandle.queryPosts()
        let post1 = Post(title: "Awesome Headshot",
                        poster: "James McDougall")
        let post2 = Post(title: "Insane 3 kill clutch",
                         poster: "@Ninja")
        dataHandle.savePost(post: post1)
        dataHandle.uploadTestData()
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
