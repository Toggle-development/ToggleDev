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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    //MARK: - Executes when App Finished Launching
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured with auth plugin")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
        
        let currentSession = currentSessionInfo()
        
        // check if a used is signed in
        currentSession.fetchCurrentAuthSession()
        
        print("Finished Launching")
        return true
    }
    
}

struct ToggleApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
