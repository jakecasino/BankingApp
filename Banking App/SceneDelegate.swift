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
import CoreData
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let userData = UserData()
    let plaidLinkData = PlaidLinkData()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Get Core Data Context
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }
        
        // Set Up Tabbed Navigation View
        let tabbedNavigationView =
            TabbedNavigationView()
                .environmentObject(userData)
                .environmentObject(plaidLinkData)
                .environment(\.managedObjectContext, context)
        
        // Set Up Plaid Data & Get Access Token from Core Data
        let plaidLink_request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaidLinkCoreData")
        plaidLink_request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(plaidLink_request)
            if let allEntities = result as? [NSManagedObject], let entity = allEntities.first {
                plaidLinkData.coreDataEntity  = entity
                if let accessTokenCoreData = entity.value(forKey: "accessToken") as? String {
                    plaidLinkData.accessToken = accessTokenCoreData
                    getAccountBalances()
                    getTransactionCategories()
                    getTransactions()
                }
            }
        } catch { print("Failed") }
        
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
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func getAccountBalances() {
        
        struct Accounts: Decodable {
            var accounts: [Account]
        }
        
        guard let accessToken = plaidLinkData.accessToken else { return }
        
        let parameters: [String : String] = [
            PlaidAPIParameterTitles.clientID.rawValue : plaidLinkData.clientID,
            PlaidAPIParameterTitles.secret.rawValue: plaidLinkData.secret,
            PlaidAPIParameterTitles.accessToken.rawValue: accessToken
        ]
        
        AF.request("\(plaidLinkData.host)accounts/balance/get", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: plaidLinkData.headers).responseJSON { response in
            
            if let data = response.data {
                if let accountData = try? JSONDecoder().decode(Accounts.self, from: data) {
                    DispatchQueue.main.async {
                        self.userData.accounts = accountData.accounts
                    }
                }
            }
        }
    }
    
    func getTransactionCategories() {
        
        AF.request("\(plaidLinkData.host)categories/get", method: .post, parameters: [String: Any](), encoding: JSONEncoding.default, headers: plaidLinkData.headers).responseJSON { response in
        
            // debugPrint("Transaction Categories")
            // debugPrint(response)
        }
    }
    
    func getTransactions() {
        
        struct Transactions: Decodable {
            var transactions: [Transaction]
        }
        
        guard let accessToken = plaidLinkData.accessToken else { return }
        
        let parameters: [String : String] = [
            PlaidAPIParameterTitles.clientID.rawValue : plaidLinkData.clientID,
            PlaidAPIParameterTitles.secret.rawValue: plaidLinkData.secret,
            PlaidAPIParameterTitles.accessToken.rawValue: accessToken,
            "start_date": "2020-01-01",
            "end_date": "2020-03-03"
        ]
        
        AF.request("\(plaidLinkData.host)transactions/get", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: plaidLinkData.headers).responseJSON { response in
            
            // debugPrint("Transactions")
            debugPrint(response)
            if let data = response.data {
                if let transactionData = try? JSONDecoder().decode(Transactions.self, from: data) {
                    DispatchQueue.main.async {
                        self.userData.transactions = transactionData.transactions
                    }
                }
            }
        }
    }

}

