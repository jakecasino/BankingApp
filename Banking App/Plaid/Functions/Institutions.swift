//
//  Institutions.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/12/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Alamofire

extension PlaidLinkData {
	
	func getInstitutionID(withAccessToken accessToken: String, _ completion: @escaping (String?) -> ()) {
		let endPoint = "item/get"
		let url = host + endPoint
		
		struct Items: Decodable {
			var item: Item
		}
		
		struct Item: Decodable {
			var institution_id: String
		}
		
		let parameters: [String : String] = [
			ParameterTitles.clientID : Parameters.clientID,
			ParameterTitles.secret: secret,
			ParameterTitles.accessToken : accessToken,
		]
		
		AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Parameters.headers).responseJSON { response in
			if let response = response.data {
				if let data = try? JSONDecoder().decode(Items.self, from: response) {
					DispatchQueue.main.async {
						completion(data.item.institution_id)
					}
				}
			}
		}
	}
	
	func getInstitutionName(withAccessToken accessToken: String, completion: @escaping (String?) -> ()) {
		
		let endPoint = "institutions/get_by_id"
		let url = host + endPoint
		
		struct Institutions: Decodable {
			var institution: Institution
		}
		
		struct Institution: Decodable {
			var name: String
		}
		
		getInstitutionID(withAccessToken: accessToken) { (institutionID) in
			guard let institutionID = institutionID else {
				fatalError("Could not get institution name.")
			}
			
			let parameters: [String : String] = [
				ParameterTitles.institutionID : institutionID,
				ParameterTitles.publicKey: Parameters.publicKey,
			]
			
			AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Parameters.headers).responseJSON { response in
				if let response = response.data {
					if let data = try? JSONDecoder().decode(Institutions.self, from: response) {
						completion(data.institution.name)
					}
				}
			}
		}
	}
}
