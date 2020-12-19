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
    
    /*
     Get a list of all the posts in the database.
     */
    func queryPosts() {
        print("Query all Posts")
        Amplify.DataStore.query(Post.self) { result in
            switch(result) {
            case .success(let posts):
                for post in posts {
                    print("==== Post ====")
                    print("Title: \(post.caption)")
                    print("Poster: \(post.postOwner)")
                }
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
            print("Queried all Posts")
        }
    }
    
    func createTestPost() {
        let testPost = Post(postOwner: "James", caption: "Wow this is epic.", numberOfLikes: 999, videoUrl: "test.mov")
        self.uploadFile(fileKey: "test.mov")
        self.createPost(post: testPost)
    }
    
    func createPost(post: Post) {
        Amplify.API.mutate(request: .create(post)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let post):
                    print("Successfully created the post: \(post)")
                case .failure(let graphQLError):
                    print("Failed to create graphql \(graphQLError)")
                }
            case .failure(let apiError):
                print("Failed to create a todo", apiError)
            }
        }
    }
    
    /*
     Upload the given filename key. Assumes the file is in the document root of the application.
     See FileManager.default.urls(for: .documentDirecotyr, in: .userDomainMask) line.
     */
    func uploadFile(fileKey: String) {
        print("FileKey:", fileKey)
        print("Files should be in here:", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileKey)
        
        Amplify.Storage.uploadFile(
            key: fileKey,
            local: filename,
            progressListener: { progress in
                print("Progress: \(progress)")
            }, resultListener: { event in
                switch event {
                case let .success(data):
                    print("Completed: \(data)")
                case let .failure(storageError):
                    print("Error: UploadFile")
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                }
            }
        )
    }
    
    /*
     Upload raw data to amplify. Probably won't ever be used in favor of file upload.
     */
    func uploadData(key: String, data: Data) {
        Amplify
            .Storage
            .uploadData(key: "ExampleKey", data: data,
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
    // -> URL
    func getS3URL(fileKey: String, completionHandler:@escaping(URL) -> ()) {
        Amplify.Storage.getURL(key: fileKey) { event in
            switch event {
            case let .success(url):
                print("S3URL: Completed: \(url)")
                completionHandler(url)
            case let .failure(storageError):
                print("S3URL: Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        }
    }
}
