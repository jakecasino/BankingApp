//
//  NCProvideDetails.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/4/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct NCView_Details: View {
	@EnvironmentObject var pageDataSource: NCPageDataSource
    
	var body: some View {
		VStack {
			Text("Page 2")
		}
    }
}

struct NCProvideDetails_Previews: PreviewProvider {
    static var previews: some View {
        NCView_Details()
    }
}
