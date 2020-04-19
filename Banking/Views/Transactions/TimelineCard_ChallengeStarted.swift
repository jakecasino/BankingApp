//
//  TimelineCard_ChallengeStarted.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TimelineCard_ChallengeStarted: View {
    var body: some View {
		TMLCard() {
			HStack {
				Spacer()
				Text("You started a challenge.")
				Spacer()
			}
			.padding()
		}
    }
}

struct TimelineCard_ChallengeStarted_Previews: PreviewProvider {
    static var previews: some View {
        TimelineCard_ChallengeStarted()
			.previewLayout(.sizeThatFits)
    }
}
