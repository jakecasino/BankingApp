//
//  PlaidViewController.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 2/28/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import UIKit
import LinkKit
import Alamofire
import CoreData

struct PlaidViewControllerRepresentable: UIViewControllerRepresentable {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var plaidLinkData: PlaidLinkData
    @Environment(\.managedObjectContext) var context
    
    func makeUIViewController(context: Context) -> PLKPlaidLinkViewController {
        let linkConfiguration = PLKConfiguration(key:
            plaidLinkData.publicKey, env: .development, product: [.transactions])
        linkConfiguration.clientName = "Docket"
        return PLKPlaidLinkViewController(configuration:
            linkConfiguration, delegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: PLKPlaidLinkViewController, context: UIViewControllerRepresentableContext<PlaidViewControllerRepresentable>) {
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: UIViewController, PLKPlaidLinkViewDelegate {
        var main: PlaidViewControllerRepresentable

        init(_ plaidViewControllerRepresentable: PlaidViewControllerRepresentable) {
            self.main = plaidViewControllerRepresentable
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didSucceedWithPublicToken publicToken: String, metadata: [String : Any]?) {
            
            getAccessToken(with: publicToken, {
                self.getAccountBalances()
            })
            dismissPlaidLinkModal()
        }
        
        func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didExitWithError error: Error?, metadata: [String : Any]?) {
            dismissPlaidLinkModal()
        }
        
        func getAccessToken(with publicToken: String, _ completionHandler: @escaping () -> Void) {
            
            let parameters: [String : String] = [
                PlaidAPIParameterTitles.clientID.rawValue : main.plaidLinkData.clientID,
                PlaidAPIParameterTitles.secret.rawValue: main.plaidLinkData.secret,
                PlaidAPIParameterTitles.publicToken.rawValue: publicToken
            ]
            
            AF.request("\(main.plaidLinkData.host)/item/public_token/exchange", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: main.plaidLinkData.headers).responseJSON { response in
                
                guard let response = response.value as? [String: String] else { return }
                
                if let accessToken = response["access_token"] {
                    self.main.plaidLinkData.accessToken = accessToken
                    print("Access Token: " + accessToken)
                    
                    if let entity = self.main.plaidLinkData.coreDataEntity {
                        entity.setValue(accessToken, forKeyPath: "accessToken")
                    } else {
                        let entity = NSEntityDescription.entity(forEntityName: "PlaidLinkCoreData", in: self.main.context)!
                        let newPlaidStoreDataEntity = NSManagedObject(entity: entity, insertInto: self.main.context)
                        newPlaidStoreDataEntity.setValue(accessToken, forKeyPath: "accessToken")
                    }
                    
                    do {
                        try self.main.context.save()
                        completionHandler()
                      } catch {
                       print("Failed saving")
                    }
                }
            }
        }
        
        func getAccountBalances() {
            struct Accounts: Decodable {
                var accounts: [Account]
            }
            
            guard let accessToken = main.plaidLinkData.accessToken else { return }
            
            let parameters: [String : String] = [
                PlaidAPIParameterTitles.clientID.rawValue : main.plaidLinkData.clientID,
                PlaidAPIParameterTitles.secret.rawValue: main.plaidLinkData.secret,
                PlaidAPIParameterTitles.accessToken.rawValue: accessToken
            ]
            
            AF.request("\(main.plaidLinkData.host)accounts/balance/get", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: main.plaidLinkData.headers).responseJSON { response in
                
                if let data = response.data {
                    if let accountData = try? JSONDecoder().decode(Accounts.self, from: data) {
                        print("Accounts")
                        print(accountData.accounts)
                        DispatchQueue.main.async {
                            self.main.userData.accounts = accountData.accounts
                        }
                    }
                }
            }
        }
        
        func getTransactions() {
            
            struct Transactions: Decodable {
                var transactions: [Transaction]
            }
            
            guard let accessToken = main.plaidLinkData.accessToken else { return }
            
            let parameters: [String : String] = [
                PlaidAPIParameterTitles.clientID.rawValue : main.plaidLinkData.clientID,
                PlaidAPIParameterTitles.secret.rawValue: main.plaidLinkData.secret,
                PlaidAPIParameterTitles.accessToken.rawValue: accessToken,
                "start_date": "2020-01-01",
                "end_date": "2020-03-03"
            ]
            
            AF.request("\(main.plaidLinkData.host)transactions/get", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: main.plaidLinkData.headers).responseJSON { response in
                
                // debugPrint("Transactions")
                debugPrint(response)
                if let data = response.data {
                    if let transactionData = try? JSONDecoder().decode(Transactions.self, from: data) {
                        DispatchQueue.main.async {
                            self.main.userData.transactions = transactionData.transactions
                        }
                    }
                }
            }
        }
        
        func dismissPlaidLinkModal() {
            main.$plaidLinkData.showPlaidLinkModal.wrappedValue = false
        }
    }
}

struct PlaidViewControllerRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        PlaidViewControllerRepresentable()
            .environmentObject(PlaidLinkData())
            .environment(\.managedObjectContext, NSManagedObjectContext())
            .previewLayout(.sizeThatFits)
    }
}
