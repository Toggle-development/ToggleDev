//
//  Data.swift
//  Toggle
//
//  Created by James McDougall on 11/8/20.
//

import Foundation
import Amplify
import AmplifyPlugins
import SwiftUI

class Database {
    
    func queryPosts() {
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
    }
    
    func uploadTestData() {
        let dataString = "Example file contents"
        let data = dataString.data(using: .utf8)!
        uploadData(key: "ExampleKey", data: data)
    }
    
    func uploadData(key: String, data: Data) {
        print("Attempting to Upload data")
        Amplify.Storage.uploadData(key: "ExampleKey", data: data,
                                   progressListener: { progress in
                                    print("Progress: \(progress)")
                                   }, resultListener: { (event) in
                                    switch event {
                                    case .success(let data):
                                        print("Completed: \(data)")
                                    case .failure(let storageError):
                                        print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                                    }
        })
        
    }
    
    func savePost(post: Post) {
        Amplify.DataStore.save(post) { result in
            switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem.title)")
            case .failure(let error):
                print("Could not save item to datastore: \(error)")
            }
        }
    }
    
}
