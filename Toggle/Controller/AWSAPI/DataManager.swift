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

class DataManager {
    
    func createPost() {
        /*let post = Post(postOwner: "walid", caption: "test", numberOfLikes: 5, videoUrl: "test")
         Amplify.API.mutate(request: .create(post)) { event in
         switch event {
         case .success(let result):
         switch result {
         case .success(let post):
         print("Successfully created the todo: \(post)")
         case .failure(let graphQLError):
         print("Failed to create graphql \(graphQLError)")
         }
         case .failure(let apiError):
         print("Failed to create a todo", apiError)
         }
         }
         }*/
        
        let post = Post(postOwner: "walid", caption: "test", numberOfLikes: 5, videoUrl: "test")
        
        Amplify.DataStore.save(post) { result in
            switch result {
            case .success:
                print("Post saved successfully!")
            case .failure(let error):
                print("Error saving post \(error)")
            }
        }
    }
}
