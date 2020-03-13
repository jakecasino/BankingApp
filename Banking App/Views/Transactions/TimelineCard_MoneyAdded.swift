//
//  TCPayDayCard.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TimelineCard_MoneyAdded: View {
	var body: some View {
		TMLCard() {
			VStack {
				HStack {
					Text("09 MAR 2020")
						.font(.system(.caption, design: .monospaced))
						.kerning(UIFont.preferredFont(forTextStyle: .caption1).pointSize * 0.15)
					Spacer()
					Text("09 MAR 2020")
						.font(.system(.caption, design: .monospaced))
				}
				HStack {
					Spacer()
					VStack(spacing: 10) {
						Image("money")
							.resizable()
							.frame(width: 60, height: 36.92)
						Text("$3300")
							.font(.largeTitle)
							.fontWeight(.semibold)
						Text("added to your cash.")
							.font(.headline)
					}
					Spacer()
				}
				.padding()
			}
			.padding()
		}
	}
}

struct TimelineCard_MoneyAdded_Previews: PreviewProvider {
    static var previews: some View {
        TimelineCard_MoneyAdded()
			.previewLayout(.sizeThatFits)
    }
}
