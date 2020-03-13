//
//  CommitmentsView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/2/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct CommitmentsView: View {
    @State var showNewCommitmentModal = false
    
	var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(showsIndicators: false) {
				VStack {
					GeometryReader { geometry in
						VStack {
							HStack {
								Text("Commitments".uppercased())
									.kerning(UIFont.preferredFont(forTextStyle: .body).pointSize * 0.2)
									.fontWeight(.bold)
								Spacer()
							}
							.padding(.top, 50.0)
							.padding(.horizontal,  30.0)
							Spacer()
							Circle()
								.trim(from: 0.3, to: 1)
								.stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
								.rotationEffect(.degrees(90))
								.rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
								.frame(width: 100, height: 100)
								// .animation(.easeOut)
							Spacer()
						}
						.background(Color(UIColor.systemTeal))
						.offset(y: geometry.frame(in: .global).minY * 0.5)
					}
						.frame(height: 550)
				}
			}.sheet(isPresented: $showNewCommitmentModal) {
				NewCommitmentView()
            }
            Button(action: {
				self.$showNewCommitmentModal.wrappedValue = true
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 17.0, weight: .regular, design: .default))
                    .frame(width: 48.0, height: 48.0)
            }
            .accentColor(Color(UIColor.label))
            .background(Color(UIColor.systemBackground))
            .cornerRadius(48.0 / 2)
            .shadow(color: Color(UIColor.systemGray5), radius: 5.0, x: 0, y: 0)
            .padding(.top, 30.0)
            .padding(.trailing, 30.0)
        }
    }
}

struct CommitmentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommitmentsView()
    }
}
