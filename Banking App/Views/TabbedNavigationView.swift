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
	
	@State var needsIntro: Bool
	
	init(needsIntro: Bool) {
		_needsIntro = State(initialValue: needsIntro)
	}
    
    var body: some View {
		VStack {
			if userData.needsAuthentication {
				if needsIntro {
					IntroView(needsIntro: $needsIntro)
				} else {
					AuthenticationView(needsAuthentication: $userData.needsAuthentication)
				}
			} else {
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
			}
		}
			.environmentObject(userData)
    }
}


// MARK: - Previews

struct TabbedNavigationView_Previews: PreviewProvider {
    static var previews: some View {
		let previewData = PreviewData()
		
		return TabbedNavigationView(needsIntro: false)
			.environmentObject(previewData.userData)
			.environmentObject(previewData.plaidLinkData)
    }
}
