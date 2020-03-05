//
//  ContentView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 2/28/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import CoreData

struct TabbedNavigationView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var plaidLinkData: PlaidLinkData
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        TabView {
            ForYouView()
                .tabItem {
                    Image(systemName: "house")
                }
            CommitmentsView()
                .tabItem {
                    Image(systemName: "archivebox")
                }
            TransactionsView()
                .tabItem {
                    Image(systemName: "dollarsign.square")
                }
            ProfileView()
                .environmentObject(plaidLinkData)
                .environment(\.managedObjectContext, context)
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                }
        }
        .environmentObject(userData)
    }
}

struct TabbedNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedNavigationView()
			.environmentObject(Sample().userData)
			.environmentObject(PlaidLinkData(developerMode: .sandbox))
            .environment(\.managedObjectContext, NSManagedObjectContext())
    }
}
