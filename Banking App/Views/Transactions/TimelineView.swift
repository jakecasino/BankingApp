//
//  TransactionsView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/2/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TimelineView: View {
	@EnvironmentObject var userData: UserData
	@State var showTransactionDetailView = false
	let screen = UIScreen.main.bounds
	
	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: 40) {
				HStack {
					Text("Timeline".uppercased())
						.kerning(UIFont.preferredFont(forTextStyle: .body).pointSize * 0.2)
						.fontWeight(.bold)
					Spacer()
					Button(action: {}) {
						Image(systemName: "line.horizontal.3.decrease.circle.fill")
							.font(.title)
					}
					.accentColor(Color(UIColor.tertiaryLabel))
				}
				.padding(.top, 50.0)
				// .padding(.horizontal,  30.0)
				
				VStack(spacing: 15.0) {
					TimelineCard_MoneyAdded()
					TimelineCard_BillPaid()
					TimelineCard_AchievementEarned()
					TimelineCard_ChallengeStarted()
					TimelineCard_ChallengeEnded()
				}
				
				if (self.userData.timeline.getEventsFor(.today).count > 0) {
					VStack {
						SectionHeader(title: "Today")
						VStack(spacing: 15.0) {
							ForEach(self.userData.timeline.getEventsFor(.today), id: \.eventID)  {
								event in
									TimelineEventCard(timelineEvent: event)
									.environmentObject(self.userData)
							}
						}
					}
				}
				
				if (self.userData.timeline.getEventsFor(.yesterday).count > 0) {
					VStack {
						SectionHeader(title: "Yesterday")
						VStack(spacing: 15.0) {
							ForEach(self.userData.timeline.getEventsFor(.yesterday), id: \.eventID)  {
								event in
									TimelineEventCard(timelineEvent: event)
									.environmentObject(self.userData)
							}
						}
					}
				}
				
				if (self.userData.timeline.getEventsFor(.thisWeek).count > 0) {
					VStack {
						SectionHeader(title: "This Week")
						VStack(spacing: 15.0) {
							if self.userData.timeline.getEventsFor(.thisWeek).count == 1 {
								TimelineEventCard(timelineEvent: self.userData.timeline.getEventsFor(.thisWeek).first!)
									.environmentObject(self.userData)
							} else if (self.userData.timeline.getEventsFor(.thisWeek).count != 0) {
								TimelineCard_TransactionGroup(transaction: (self.userData.timeline.getEventsFor(.thisWeek).first!.transaction!))
							}
							
						}
					}
				}
				
				if (self.userData.timeline.getEventsFor(.lastWeek).count > 0) {
					VStack {
						SectionHeader(title: "Last Week")
						VStack(spacing: 15.0) {
							if self.userData.timeline.getEventsFor(.lastWeek).count == 1 {
								TimelineEventCard(timelineEvent: self.userData.timeline.getEventsFor(.lastWeek).first!)
									.environmentObject(self.userData)
							} else if (self.userData.timeline.getEventsFor(.lastWeek).count != 0) {
								TimelineCard_TransactionGroup(transaction: (self.userData.timeline.getEventsFor(.lastWeek).first!.transaction!))
							}
							
						}
					}
				}
				
				if (self.userData.timeline.getEventsFor(.thisMonth).count > 0) {
					VStack {
						SectionHeader(title: "This Month")
						VStack(spacing: 15.0) {
							if self.userData.timeline.getEventsFor(.thisMonth).count == 1 {
								TimelineEventCard(timelineEvent: self.userData.timeline.getEventsFor(.thisMonth).first!)
									.environmentObject(self.userData)
							} else if (self.userData.timeline.getEventsFor(.thisMonth).count != 0) {
								TimelineCard_TransactionGroup(transaction: (self.userData.timeline.getEventsFor(.lastMonth).first!.transaction!))
							}
							
						}
					}
				}
				
				if (self.userData.timeline.getEventsFor(.lastMonth).count > 0) {
					VStack {
						SectionHeader(title: "Last Month")
						VStack(spacing: 15.0) {
							if self.userData.timeline.getEventsFor(.lastMonth).count == 1 {
								TimelineEventCard(timelineEvent: self.userData.timeline.getEventsFor(.thisMonth).first!)
									.environmentObject(self.userData)
							} else if (self.userData.timeline.getEventsFor(.lastMonth).count != 0) {
								TimelineCard_TransactionGroup(transaction: (self.userData.timeline.getEventsFor(.lastMonth).first!.transaction!))
							}
							
						}
					}
				}
			}
			.padding()
		}
		.background(Color("background"))
		.edgesIgnoringSafeArea(.all)
	}
}

//struct TransactionsView_Previews: PreviewProvider {
//	static var previews: some View {
//		TimelineView()
//			.environmentObject(Sample().userData)
//			.environmentObject(Sample().timeline)
//			.previewLayout(.sizeThatFits)
//	}
//}
