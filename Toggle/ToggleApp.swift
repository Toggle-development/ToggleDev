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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var sessionManager = SessionManager()
    
    init() {
        configureAmplify()
        sessionManager.getCurrentAuthUser()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(sessionManager)
        }
    }
    
    private func configureAmplify() {
        do {
            let models = AmplifyModels()
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: models))
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: models))
            try Amplify.add(plugin: AWSS3StoragePlugin())
            
            try Amplify.configure()
            print("Amplify configured with auth plugin")
            
            
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
    //MARK: - Executes when App Finished Launching
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Finished Launching")
        return true
    }
    
}

struct ToggleApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
