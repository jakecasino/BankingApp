//
//  SceneDelegate.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 2/28/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import UIKit
import SwiftUI
import LinkKit

#if DEVELOPMENT
let developerMode = DeveloperModes.sandbox
#else
let developerMode = DeveloperModes.development
#endif

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
	@State var userData = UserData()
	@State var plaidLinkData = PlaidLinkData(developerMode: developerMode)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
        // MARK: - Set Up Data
		
		// Connect UserData to PlaidLinkData, vice versa
		userData.plaidLinkData = $plaidLinkData
		plaidLinkData.userData = $userData
		
		// Fetch Data
		userData.initializeCoreData()
        
		
		// MARK: - Set Up Main View
		
		let tabbedNavigationView =
            TabbedNavigationView()
                .environmentObject(userData)
                .environmentObject(plaidLinkData)
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(
                rootView: tabbedNavigationView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
		// Save Core Data
		userData.saveContext()
    }

}
