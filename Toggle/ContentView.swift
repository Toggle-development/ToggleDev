//
//  ContentView.swift
//  Toggle
//
//  Created by user185695 on 10/27/20.
//

import SwiftUI
import Amplify
import AmplifyPlugins

struct ContentView: View {
    func performOnAppear() {
        let item = Post(title: "Awesome Headshot",
                        poster: "James McDougall")
        
        Amplify.DataStore.save(item) { result in
            switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem.title)")
            case .failure(let error):
                print("Could not save item to datastore: \(error)")
            }
        }
        
        let item2 = Post(title: "Insane 3 kill clutch",
                         poster: "@Ninja")
        
        Amplify.DataStore.save(item2) { result in
            switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem.title)")
            case .failure(let error):
                print("Could not save item to datastore: \(error)")
            }
        }
        
        print("Query all Posts")
        Amplify.DataStore.query(Post.self) { result in
            switch(result) {
            case .success(let posts):
                for post in posts {
                    print("==== Post ====")
                    print("Title: \(post.title)")
                    print("Poster: \(post.poster)")
                }
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
            print("Queried all Posts")
        }

        
        
        print("Uploading file")
        let dataString = "My Data"
        let data = dataString.data(using: .utf8)!
        let storageOperation = Amplify.Storage.uploadData(key: "ExampleKey", data: data)
        let progressSink = storageOperation.progressPublisher.sink { progress in print("Progress: \(progress)") }
        let resultSink = storageOperation.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                print("Upload-Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        }
        receiveValue: { data in
            print("Upload-Completed: \(data)")
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
