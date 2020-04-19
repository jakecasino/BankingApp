//
//  NCPageSelector.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/4/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct NCPageDataDelegate: View {
	@EnvironmentObject var pageDataSource: NCPageDataSource
	var page: NCPageTypes
	
	var body: some View {
		VStack {
			if page == .nameTheCommitment {
				NCPage_Title()
			} else if page == .provideDetails {
				NCPage_Details()
			} else if page == .confirmation {
				NCPage_Confirmation()
			}
		}
			.environmentObject(pageDataSource)
	}
}
