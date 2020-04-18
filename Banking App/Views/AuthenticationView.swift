//
//  AuthenticationView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 4/17/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
	@EnvironmentObject var userData: UserData
	@State var needsAuthentication: Binding<Bool>
	
    var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer()
				Text("AuthenticationView")
				Spacer()
			}
			Button(action: {
				self.needsAuthentication.wrappedValue.toggle()
			}) {
				Text("Authenticate")
			}
			Spacer()
		}
			.background(Color(UIColor.systemBackground))
			.edgesIgnoringSafeArea(.all)
			.onAppear(perform: {
				
				// Face ID Authentication
				
				guard self.userData.appSettings.unlockWithBiometrics == true else { return }
				
				let context = LAContext()
				var error: NSError?

				
				if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
					
					let reason = "We need to unlock your data."

					context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
						
						DispatchQueue.main.async {
							if success {
								self.needsAuthentication.wrappedValue.toggle()
							} else {
								
							}
						}
					}
				} else {
					
				}
			})
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
		AuthenticationView(needsAuthentication: .constant(true))
    }
}
