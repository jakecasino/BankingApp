//
//  ContentView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 2/28/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import Combine
import LinkKit
import CoreData
import Alamofire

final class PlaidStore: ObservableObject {
    @Published var showPlaidLinkModal = false
    @Published var accounts = [Account]()
    @Published var plaidStoreCoreData: [NSManagedObject] = []
    let host = "https://sandbox.plaid.com/"
    let publicKey = "def4ad236b8b7c59f32fdf31f1bdb0"
    let headers: HTTPHeaders = ["Content-Type": "application/json"]
    
    var publicToken: String?
    var itemID: String?
    var parameters = [
            "client_id": "5de493c9c72d7b0012cb1f3a",
            "secret": "56b7340726b45dfa709a700277d981", // Secret for Sandbox
            "access_token" : ""
        ]
    
    init()  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaidStoreData")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if let allEntities = result as? [NSManagedObject], let entity = allEntities.first {
                if let accessTokenCoreData = entity.value(forKey: "accessToken") as? String {
                    parameters.updateValue(accessTokenCoreData, forKey: "access_token")
                    getAccountBalances()
                } else {
                    getAccessToken(context: context, entity: entity)
                }
            }
        } catch { print("Failed") }
    }
    
    func getAccessToken(context: NSManagedObjectContext, entity: NSManagedObject?) {
        guard let publicToken = publicToken else { return }
        
        var parameters = self.parameters
        parameters.removeValue(forKey: "access_token")
        parameters["public_token"] = publicToken
        
        AF.request("\(host)/item/public_token/exchange", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            guard let response = response.value as? [String: String] else { return }
            
            if let accessToken = response["access_token"] {
                if let itemID = response["item_id"] { self.itemID = itemID }
                parameters.updateValue(accessToken, forKey: "access_token")
                DispatchQueue.main.async {
                    self.getAccountBalances()
                }
                
                if let entity = entity {
                    entity.setValue(accessToken, forKeyPath: "accessToken")
                } else {
                    let entity = NSEntityDescription.entity(forEntityName: "PlaidStoreData", in: context)!
                    let newPlaidStoreDataEntity = NSManagedObject(entity: entity, insertInto: context)
                    newPlaidStoreDataEntity.setValue(accessToken, forKeyPath: "accessToken")
                }
                
                do {
                   try context.save()
                  } catch {
                   print("Failed saving")
                }
            }
        }
    }
    
    func getAccountBalances() {
        AF.request("\(host)accounts/balance/get", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            if let data = response.data {
                do {
                    if let accounts = try? JSONDecoder().decode(Accounts.self, from: data) {
                        DispatchQueue.main.async {
                            self.accounts = accounts.accounts
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct AccountRowView: View {
    var name: String
    var currentBalance: Double
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(String(format: "%.2f", currentBalance))
        }
    }
}

struct TabbedNavigationView: View {
    
    var body: some View {
        TabView {
            Text("Home")
                .tabItem {
                    Image(systemName: "house")
                }
            Text("Commitments")
                .tabItem {
                    Image(systemName: "archivebox")
                }
            TransactionsView()
                .tabItem {
                    Image(systemName: "dollarsign.square")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                }
        }
        .font(.headline)
    }
}

struct ProfileView: View {
    @ObservedObject var plaidStore = PlaidStore()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    if plaidStore.accounts.count > 0 {
                        ForEach(plaidStore.accounts, id: \.name) { account in
                            AccountRowView(name: account.name, currentBalance: account.balances.current)
                        }
                    } else {
                        Button(action: {
                            self.$plaidStore.showPlaidLinkModal.wrappedValue = true
                        }) {
                            Text("Show Plaid")
                        }.sheet(isPresented: self.$plaidStore.showPlaidLinkModal) {
                            PlaidViewControllerRepresentable(plaidStore: self.plaidStore)
                                .edgesIgnoringSafeArea(.all)
                        }
                    }
                }
                .navigationBarTitle(Text("Accounts"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedNavigationView()
    }
}
