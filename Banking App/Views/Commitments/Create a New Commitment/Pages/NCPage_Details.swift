//
//  NCProvideDetails.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/4/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct NCPage_Details: View {
	@EnvironmentObject var pageDataSource: NCPageDataSource
    
	var body: some View {
		VStack(alignment: .leading, spacing: 50.0) {
			HStack {
				VStack(alignment: .leading, spacing: 10.0) {
					Text("For")
						.font(.headline)
						.fontWeight(.bold)
					Text(pageDataSource.name)
						.font(.largeTitle)
						.fontWeight(.bold)
				}
				Spacer()
			}
				.padding(.horizontal, 30.0)
			HStack {
				VStack(alignment: .leading, spacing: 10.0) {
					Text("I'd like to commit")
						.font(.headline)
						.fontWeight(.bold)
					TextField("$100", text: $pageDataSource.amountToCommitString)
						.font(.largeTitle)
				}
				Spacer()
			}
				.padding(.horizontal, 30.0)
			HStack {
				VStack(alignment: .leading, spacing: 10.0) {
					Text("Every")
						.font(.headline)
						.fontWeight(.bold)
						.padding(.leading, 30.0)
					ScrollView(.horizontal, showsIndicators: false, content: {
						HStack(spacing: 30.0) {
							Text("Month")
								.font(.largeTitle)
								.fontWeight(.bold)
								.padding(.leading, 30.0)
							Text("Year")
								.font(.largeTitle)
								.fontWeight(.bold)
								.foregroundColor(Color(UIColor.tertiaryLabel))
							Text("Week")
								.font(.largeTitle)
								.fontWeight(.bold)
								.foregroundColor(Color(UIColor.tertiaryLabel))
							Text("2 Weeks")
								.font(.largeTitle)
								.fontWeight(.bold)
								.foregroundColor(Color(UIColor.tertiaryLabel))
								.padding(.trailing, 30.0)
						}
					})
				}
				Spacer()
			}
			HStack {
				Button(action: {}) {
					Text("I earn $4260 every month")
						.foregroundColor(Color(UIColor.secondaryLabel))
					Image(systemName: "gear")
						.foregroundColor(Color(UIColor.secondaryLabel))
				}
			}
				.padding(.horizontal, 30.0)
			Spacer()
		}
		.padding(.vertical, 30.0)
    }
}

struct NCProvideDetails_Previews: PreviewProvider {
    static var previews: some View {
        NCPage_Details()
			.environmentObject(NCPageDataSource())
			.previewLayout(.sizeThatFits)
    }
}
