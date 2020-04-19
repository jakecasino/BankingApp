//
//  TMLBillPaid.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TimelineCard_BillPaid: View {
	var body: some View {
		TMLCard() {
			HStack {
				Spacer()
				Text("You paid your Netflix Bill.")
				Spacer()
			}
			.padding()
		}
	}
}

struct TMLBillPaid_Previews: PreviewProvider {
    static var previews: some View {
        TimelineCard_BillPaid()
			.previewLayout(.sizeThatFits)
    }
}
