//
//  NCNameTheCommitmentView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/4/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct NCPage_Title: View {
	@EnvironmentObject var pageDataSource: NCPageDataSource
    
	var body: some View {
		VStack {
			Text("Page 1")
		}
			.padding(30.0)
    }
}

struct NCNameTheCommitmentView_Previews: PreviewProvider {
    static var previews: some View {
		NCPage_Title()
    }
}
