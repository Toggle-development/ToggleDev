//
//  ContentView.swift
//  Toggle
//
//  Created by user185695 on 10/27/20.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    func performOnAppear() {
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
