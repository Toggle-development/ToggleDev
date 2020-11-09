//
//  PostViewModel.swift
//  Toggle
//
//  Created by Walid Rafei on 11/7/20.
//

import Foundation
class PostViewModel: ObservableObject {
    @Published var posts = [OGPost]()
    
    //here we call API to get posts data, for now it's hard coded. The Post() struct is created under Model section
    init () {
        let post1 = OGPost(id: 0, postOwner: "Walid Rafei", caption: "This is awesome", numberOfLikes: 10, videoURL:"https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")
        let post2 = OGPost(id: 1, postOwner: "Andrew", caption: "Great News", numberOfLikes: 9, videoURL: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")
        let post3 = OGPost(id: 2, postOwner: "James", caption: "I had so much fun", numberOfLikes: 15, videoURL: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")
        
        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
    }
}
