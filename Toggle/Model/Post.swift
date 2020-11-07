//
//  Post.swift
//  Toggle
//
//  Created by Walid Rafei on 11/7/20.
//

import Foundation
struct Post: Identifiable, Hashable {
    var id: Int
    let postOwner: String
    let caption: String
    let numberOfLikes: Int
    let videoURL: String
}
