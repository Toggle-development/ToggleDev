//
//  SearchView.swift
//  Toggle
//
//  Created by user185695 on 11/7/20.
//

import SwiftUI
import Amplify

struct SearchView: View {
    
    // I believe here, you could pass a state variable to the model init to generate a
    // different search view.
    @ObservedObject private var searchViewModel = SearchViewModel(query: "James")
    
    var body: some View {
        Text("Search Coming Soon")
        let _ = print("Search: \(searchViewModel.posts)")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
