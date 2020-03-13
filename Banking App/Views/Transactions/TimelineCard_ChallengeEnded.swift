//
//  TimelineCard_ChallengeEnded.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TimelineCard_ChallengeEnded: View {
    var body: some View {
		TMLCard() {
			HStack {
				Spacer()
				Text("You ended a challenge.")
				Spacer()
			}
			.padding()
		}
    }
}

struct TimelineCard_ChallengeEnded_Previews: PreviewProvider {
    static var previews: some View {
        TimelineCard_ChallengeEnded()
			.previewLayout(.sizeThatFits)
    }
}
