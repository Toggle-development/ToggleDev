//
//  PostViewModel.swift
//  Toggle
//
//  Created by Walid Rafei on 11/7/20.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    //here we call API to get posts data, for now it's hard coded. The Post() struct is created under Model section
    init () {
        DataManager().queryPosts() { ps in
            self.posts = ps
        }
    }
}
