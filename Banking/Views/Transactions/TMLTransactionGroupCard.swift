//
//  TMLTransactionGroupCard.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TimelineCard_TransactionGroup: View {
    var body: some View {
		TMLCard() {
			HStack {
				Spacer()
				Text("You spent $80 last week.")
				Spacer()
			}
			.padding()
		}
	}
}

struct TMLTransactionGroupCard_Previews: PreviewProvider {
    static var previews: some View {
        TimelineCard_TransactionGroup()
			.previewLayout(.sizeThatFits)
    }
}
