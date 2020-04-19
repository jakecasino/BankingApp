/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view for bridging a UIPageViewController.
*/

import SwiftUI

final class NCPageDataSource: ObservableObject {
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

enum NCPages {
	case nameTheCommitment
	case provideDetails
}

struct NCPageSelectorView: View {
	@EnvironmentObject var pageDataSource: NCPageDataSource
	var page: NCPages
	
	var body: some View {
		VStack {
			if page == .nameTheCommitment {
				NCView_Title()
			} else if page == .provideDetails {
				NCView_Details()
			}
		}
			.environmentObject(pageDataSource)
	}
}

struct NewCommitmentView: View {
	var pageDataSource = NCPageDataSource()
    var viewControllers: [UIHostingController<NCPageSelectorView>]

	init() {
		let views = [
			NCPageSelectorView(page: .nameTheCommitment),
			NCPageSelectorView(page: .provideDetails)
		]
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
			NCPageViewController(controllers: viewControllers)
				.environmentObject(pageDataSource)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
		NewCommitmentView()
    }
}
