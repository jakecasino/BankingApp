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
    
    var body: some View {
        TabView {
            TimelineView()
                .tabItem {
                    Image(systemName: "house")
                }
            ProfileView()
                .environmentObject(plaidLinkData)
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                }
        }
			.environmentObject(userData)
    }
}


// MARK: - Previews

struct TabbedNavigationView_Previews: PreviewProvider {
    static var previews: some View {
		let previewData = PreviewData()
		
        return TabbedNavigationView()
			.environmentObject(previewData.userData)
			.environmentObject(previewData.plaidLinkData)
    }
}
