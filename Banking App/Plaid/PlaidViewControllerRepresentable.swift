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

#if DEVELOPMENT
let plaidEnvironment = PLKEnvironment.sandbox
#else
let plaidEnvironment = PLKEnvironment.development
#endif

struct PlaidViewControllerRepresentable: UIViewControllerRepresentable {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var plaidLinkData: PlaidLinkData
    
    func makeUIViewController(context: Context) -> PLKPlaidLinkViewController {
        let linkConfiguration = PLKConfiguration(key:
			PlaidLinkData.Parameters.publicKey, env: plaidEnvironment, product: [.transactions])
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
            
			main.plaidLinkData.getAccessToken(with: publicToken) { (accessToken) in
				guard let accessToken = accessToken else { return }
				self.main.userData.addBankInstitution(linkedWithPlaidAccessToken: accessToken)
			}
            dismissPlaidLinkModal()
        }
        
        func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didExitWithError error: Error?, metadata: [String : Any]?) {
            dismissPlaidLinkModal()
        }
        
        func dismissPlaidLinkModal() {
            main.$plaidLinkData.showPlaidLinkModal.wrappedValue = false
        }
    }
}

struct PlaidViewControllerRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        PlaidViewControllerRepresentable()
			.environmentObject(PlaidLinkData(developerMode: .sandbox))
            .previewLayout(.sizeThatFits)
    }
}
