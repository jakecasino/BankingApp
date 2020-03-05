/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view for bridging a UIPageViewController.
*/

import SwiftUI

struct NewCommitmentView: View {
    @Environment(\.presentationMode) var presentationMode
	
	@ObservedObject var pageDataSource = NCPageDataSource()
    var viewControllers: [UIHostingController<NCPageDataDelegate>]
	@State var keyboardHeight: CGFloat = 0

	init() {
		let views = [
			NCPageDataDelegate(page: .nameTheCommitment),
			NCPageDataDelegate(page: .provideDetails),
			NCPageDataDelegate(page: .confirmation)
		]
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        GeometryReader { geometry in
			VStack {
				VStack() {
					HStack {
						if self.pageDataSource.currentPage == 0 {
							Button(action: {
								self.presentationMode.wrappedValue.dismiss()
							}) {
								Image(systemName: "chevron.down.circle.fill")
									.font(.title)
									.accentColor(Color(UIColor.tertiaryLabel))
									.padding(25.0)
									
							}
						} else {
							Button(action: {
								self.pageDataSource.goToPreviousPage()
							}) {
								Image(systemName: "arrow.left")
									.font(.title)
									.accentColor(Color(UIColor.tertiaryLabel))
									.padding(25.0)
							}
						}
						Spacer()
					}
					
					ZStack(alignment: .bottomTrailing) {
						NCPageViewController(controllers: self.viewControllers)
							.environmentObject(self.pageDataSource)
						HStack {
							Spacer()
							if self.pageDataSource.currentPage + 1 != self.viewControllers.count {
								Button(action: {
									self.pageDataSource.goToNextPage()
								}) {
									Image(systemName: "arrow.right")
										.frame(width: 56.0, height: 56.0)
										.background(Color(UIColor.label))
										.cornerRadius(56.0 / 2)
										.font(.headline)
										.accentColor(Color(UIColor.systemBackground))
								}
							}
						}
						.padding(30.0)
					}
				}
				.highPriorityGesture(DragGesture())
				.frame(height: geometry.size.height - self.keyboardHeight)
				.animation(.spring())
				.onAppear  {
					NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main)  {
						(notification) in
						
						let value  = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
						// self.value = value.height
						self.keyboardHeight = value.height
						
					}
					NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main)  {
						(_) in
						
						self.keyboardHeight = 0
					}
				}
				Spacer()
			}
        }
		.edgesIgnoringSafeArea(.bottom)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
		NewCommitmentView()
    }
}
