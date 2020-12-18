//
//  listenToSessionUpdates.swift
//  Toggle
//
//  Created by Walid Rafei on 10/30/20.
//

import Foundation
import Amplify
import AmplifyPlugins

class listenToSessionUpdates {
    
    // this should not be type optional probably, will figure out later.
    var unsubscribeToken: UnsubscribeToken? = nil;
    
    /*
     * this function listens to any changes that occur within .auth such as logout, login
     * or session expiration and should execute code accordingly.
     */
    func listenToUpdates() {
        unsubscribeToken = Amplify.Hub.listen(to: .auth) { payload in
            switch payload.eventName {
            case HubPayload.EventName.Auth.signedIn:
                print("User signed in")
                // Update UI

            case HubPayload.EventName.Auth.sessionExpired:
                print("Session expired")
                // Re-authenticate the user

            case HubPayload.EventName.Auth.signedOut:
                print("User signed out")
                // Update UI

            default:
                break
            }
        }
    }
}
