//
//  NCView_Confirmation.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/4/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct NCPage_Confirmation: View {
	@EnvironmentObject var pageDataSource: NCPageDataSource
	
    var body: some View {
		VStack(spacing: 30.0) {
			VStack(spacing: 10.0) {
				Text("I, Monica Torres, will commit")
					.font(.system(.body, design: .serif))
				Text("\(pageDataSource.amountToCommitString) every month")
					.font(.system(.title, design: .serif))
					.fontWeight(.bold)
			}
				.padding(.horizontal, 10.0)
			VStack(spacing: 10.0) {
				Text("of my $4260 monthly income to")
					.font(.system(.body, design: .serif))
				Text(pageDataSource.name)
					.font(.system(.title, design: .serif))
					.fontWeight(.bold)
			}
				.padding(.horizontal, 10.0)
			VStack {
				Button(action: {}) {
					HStack {
						Spacer()
						Text("Create your commitment")
							.fontWeight(.bold)
						Spacer()
					}
						.padding(.vertical, 20.0)
						.background(Color(UIColor.label))
						.accentColor(Color(UIColor.systemBackground))
						.cornerRadius(10.0,  antialiased: true)
				}
					.padding(.vertical, 20.0)
				Text("Make this a binding contract to yourself.")
			}
		}
		.padding(20.0)
    }
}

struct NCView_Confirmation_Previews: PreviewProvider {
    static var previews: some View {
        NCPage_Confirmation()
			.environmentObject(NCPageDataSource())
    }
}
