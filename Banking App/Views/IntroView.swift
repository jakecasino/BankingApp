//
//  IntroView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 4/17/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct IntroView: View {
	@State var needsIntro: Binding<Bool>
	
    var body: some View {
		VStack {
			Text("IntroView")
			Button(action: {
				self.needsIntro.wrappedValue.toggle()
			}) {
				Text("Sign In")
			}
		}
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
		IntroView(needsIntro: .constant(true))
    }
}
