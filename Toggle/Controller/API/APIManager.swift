//
//  APIManager.swift
//  Toggle
//
//  Created by James McDougall on 12/26/20.
//

import Foundation
import Amplify
import Combine

let post = Post.keys


func search(q: String, completion:@escaping([Post]) -> ()) {
    let post = Post.keys
    let p = post.postOwner == q || post.caption == q
    query(predicate: p) { posts in
        completion(posts)
    }
}


func searchUsers(user: String) {
    query(predicate: post.postOwner == user) { posts in
        print("Posts for user \(user): \(posts)")
    }
}

func searchTitle(caption: String) {
    query(predicate: post.caption == caption) { posts in
        print("Posts for caption '\(caption)': \(posts)")
    }
}

func searchId(id: String) {
    query(predicate: post.id == id) { posts in
        print("Posts for ID \(id): \(posts)")
    }
}

func query(predicate: QueryPredicate, completion:@escaping([Post]) -> ()) {
    Amplify.API.query(request: .list(Post.self, where: predicate)) { event in
        switch event {
        case .success(let result):
            switch result {
            case .success(let post):
                print("Successfully retrieved list of posts: \(post)")
                completion(post)
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        case .failure(let error):
            print("Got failed event with error \(error)")
        }
    }
}


func searchCombine(user: String) -> AnyCancellable {
    let post = Post.keys
    let predicate = post.postOwner == user
    let sink = Amplify.API.query(request: .list(Post.self, where: predicate))
        .resultPublisher
        .sink {
            if case let .failure(error) = $0 {
                print("Got failed event with error \(error)")
            }
        }
        receiveValue: { result in
            switch result {
            case .success(let todo):
                print("Successfully retrieved list of todos: \(todo)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        }
    return sink
}
