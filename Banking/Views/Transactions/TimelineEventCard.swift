//
//  TimelineEventCard.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TimelineEventCard: View {
    @EnvironmentObject var userData: UserData
	@EnvironmentObject var timeline: Timeline
	let timelineEvent: TimelineEvent
	
	var body: some View {
		VStack {
			containedView()
		}
	}

	func containedView() -> AnyView? {
		switch timelineEvent.type {
			case .transaction:
				guard let transaction = timelineEvent.transaction else { return nil }
				return AnyView(TransactionButton(transaction: transaction).environmentObject(self.userData))
			case .transactionGroup:
				guard let transaction = timelineEvent.transaction else { return nil }
				return AnyView(TimelineCard_TransactionGroup(transaction: transaction).environmentObject(self.userData))
			default:
				return nil
		}
	}
}


//struct TimelineEventCard_Previews: PreviewProvider {
//    static var previews: some View {
//		TimelineEventCard(timelineEvent: TimelineEvent(eventID: UUID(), date: Date(), type: .transaction, transaction: Transaction(account_id: "0", name: "Golden Crepes", amount: 24.0, date: "2020-03-03", payment_channel: "online")))
//		.environmentObject(Sample().userData)
//		.previewLayout(.sizeThatFits)
//    }
//}
