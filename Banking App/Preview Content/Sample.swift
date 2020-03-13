//
//  UserDataSample.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/4/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import Alamofire

final class PreviewData: ObservableObject  {
    static let sample = PreviewData()
    private static let accessToken = "access-sandbox-e7ba0491-0f60-4ebb-a963-3b653f680d7f"
    
    @State var userData = UserData()
    @State var plaidLinkData = PlaidLinkData(developerMode: .sandbox)
    
    init() {
        userData.plaidLinkData = $plaidLinkData
        plaidLinkData.userData = $userData
    }
}
