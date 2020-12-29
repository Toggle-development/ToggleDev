//
//  SearchViewModel.swift
//  Toggle
//
//  Created by James McDougall on 12/27/20.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init(query: String) {
        search(q: query) {ps in
            self.posts = ps
        }
    }
}
