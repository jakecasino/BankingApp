//
//  UserDataSample.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/4/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Combine

final class Sample: ObservableObject  {
    var userData = UserData()
    
    init() {
        userData.accounts = [Account]()
    }
}
