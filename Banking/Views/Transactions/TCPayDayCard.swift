//
//  TCPayDayCard.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TMLYouGotPaidCard: View {
	var body: some View {
		HStack {
			Spacer()
			VStack(spacing: 10) {
				Image("money")
					.resizable()
					.frame(width: 182, height: 112)
				Text("You Got Paid")
					.font(.headline)
				Text("$3300")
					.font(.largeTitle)
			}
			Spacer()
		}
		.padding(.vertical, 50)
		.background(Color(UIColor.systemBackground))
		.cornerRadius(10, antialiased: true)
		.shadow(color: Color(UIColor(white: 0, alpha: 0.05)), radius: 6, x: 0, y: 1)
		.padding()
	}
}

struct TCPayDayCard_Previews: PreviewProvider {
    static var previews: some View {
        TMLYouGotPaidCard()
			.previewLayout(.sizeThatFits)
    }
}
