//
//  ToggleApp.swift
//  Toggle
//
//  Created by user185695 on 10/27/20.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct ToggleApp: App {
    func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels())
            )
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            // simplified error handling for the tutorial
            print("Could not initialize Amplify: \(error)")
        }
        //Amplify.DataStore.clear()
    }
    
    func fetchCurrentAuthSession() {
        _ = Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                print("Is user signed in - \(session.isSignedIn)")
            case .failure(let error):
                print("Fetch session failed with error \(error)")
            }
        }
    }

    public init() {
        configureAmplify()
        //fetchCurrentAuthSession()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
