//
//  SectionHeader.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/2/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct SectionHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
        }
        .padding(.top, 50.0)
        .padding(.horizontal, 30.0)
        .padding(.bottom, 20.0)
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SectionHeader(title: "Section Title")
        }
        .previewLayout(.sizeThatFits)
    }
}
