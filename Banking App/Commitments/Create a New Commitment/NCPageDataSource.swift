//
//  NCPageDataSource.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/4/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Combine

final class NCPageDataSource: ObservableObject {
	@Published var name =  "Rent"
	@Published var amountToCommit =  100.00
	@Published var amountToCommitString =  "$100"
	
	@Published var currentPage = 0
	@Published var previousPage: Int?
	
	func updatePreviousPageIndex() {
		previousPage = currentPage
	}
	
	func goToNextPage() {
		updatePreviousPageIndex()
		currentPage += 1
	}
	
	func goToPreviousPage() {
		updatePreviousPageIndex()
		currentPage -= 1
	}
}
