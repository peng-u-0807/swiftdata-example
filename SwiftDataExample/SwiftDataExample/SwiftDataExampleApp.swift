import SwiftUI

@main
struct SwiftDataExampleApp: App {
    var body: some Scene {
        WindowGroup {
            MyReviewListView()
                .preferredColorScheme(.dark)
                .background(CustomColor.background.color)
                .tint(.white)
        }
    }
}
