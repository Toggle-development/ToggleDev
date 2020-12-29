//
//  User.swift
//  Toggle
//
//  Created by James McDougall on 12/20/20.
//

import Foundation

struct User {
    let dataManager: DataManager = DataManager()
    var username: String
    
    init(username: String) {
        self.username = username
    }
    
    /*
     TODO: Need to create a new Table with user ProfileData. TBD.
     */
    func getProfileData(
        completionHandler:@escaping() -> ()){
        
    }
}
