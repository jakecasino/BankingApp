//
//  AppSettingsView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 4/18/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI


struct AppSettingsView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
			Spacer()
			Toggle("Sign In with FaceID", isOn: self.$userData.appSettings.prefersUnlockWithBiometrics)
			Button(action:{
				self.presentationMode.wrappedValue.dismiss()
			}) {
				Text("Close Modal")
			}
			Spacer()
        }
			.padding()
			.background(Color("background"))
    }
}

struct AppSettingsView_Previews: PreviewProvider {
    static var previews: some View {
		let previewData = PreviewData()
        
		return AppSettingsView()
			.environmentObject(previewData.userData)
    }
}
