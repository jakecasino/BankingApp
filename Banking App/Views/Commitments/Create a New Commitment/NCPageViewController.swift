/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that wraps a UIPageViewController.
*/

import SwiftUI
import UIKit

struct NCPageViewController: UIViewControllerRepresentable {
	@EnvironmentObject var pageDataSource: NCPageDataSource
    
	var controllers: [UIViewController]

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)

        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
		var navigationDirection = UIPageViewController.NavigationDirection.forward
		
		if let previousPage = pageDataSource.previousPage {
			if pageDataSource.currentPage < previousPage {
				navigationDirection = .reverse
			}
		}
        pageViewController.setViewControllers(
			[controllers[pageDataSource.currentPage]], direction: navigationDirection, animated: true)
    }
}
