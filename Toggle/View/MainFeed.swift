//
//  MainFeedCell.swift
//  Toggle
//
//  Created by Walid Rafei on 11/5/20.
//

import SwiftUI
import AVKit

struct MainFeed: View {
    //observe the posts ovject from PostViewModel to update screen according to data we get.
    @ObservedObject private var postViewModel = PostViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            List {
                // for each post in post in posts create a post cell
                ForEach(postViewModel.posts, id: \.id) {post in
                    PostCell(postOwner: post.postOwner, videoURL: post.videoURL, caption: post.caption, postFrame: geometry)
                }
            }
        }
    }
}

struct MainFeed_Previews: PreviewProvider {
    static var previews: some View {
        MainFeed()
    }
}
