//
//  TMLBaseCard.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

func TMLCard<Content>(@ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
	
    var body: some View {
		VStack {
			content()
		}
			.background(Color(UIColor.systemBackground))
			.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
			.shadow(color: Color(UIColor(white: 0, alpha: 0.05)), radius: 6, x: 0, y: 1)
    }
	
	return body
}

struct TMLBaseCard_Previews: PreviewProvider {
    static var previews: some View {
		HStack {
			TMLCard() {
				Text("Hello")
			}
		}
		.frame(width: 375, height: 375)
		.background(Color("background"))
		.previewLayout(.sizeThatFits)
    }
}
