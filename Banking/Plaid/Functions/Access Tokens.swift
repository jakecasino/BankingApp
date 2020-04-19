//
//  Fetching Access Tokens.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/12/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Alamofire

extension PlaidLinkData {
	func getAccessToken(with publicToken: String, _ completion: @escaping (String?) -> ()) {
		var accessToken: String?
		
		let endPoint = "item/public_token/exchange"
		let url = host + endPoint
		
		let parameters: [String : String] = [
			ParameterTitles.clientID : Parameters.clientID,
			ParameterTitles.secret: secret,
			ParameterTitles.publicToken: publicToken
		]
		
		AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Parameters.headers).responseJSON { response in
			guard let response = response.value as? [String: String] else { return }
			accessToken = response["access_token"]
			completion(accessToken)
		}
	}
}
