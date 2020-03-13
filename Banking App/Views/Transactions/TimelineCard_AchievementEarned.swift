//
//  TimelineCard_AchievementEarned.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TimelineCard_AchievementEarned: View {
    var body: some View {
		TMLCard() {
			HStack {
				Spacer()
				Text("You earned an achievement.")
				Spacer()
			}
			.padding()
		}
    }
}

struct TimelineCard_AchievementEarned_Previews: PreviewProvider {
    static var previews: some View {
        TimelineCard_AchievementEarned()
			.previewLayout(.sizeThatFits)
    }
}
