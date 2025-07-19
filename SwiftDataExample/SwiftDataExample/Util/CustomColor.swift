import SwiftUI

enum CustomColor: String {
    case blue = "CustomBlue"
    case red = "CustomRed"
    case darkGray = "CustomDarkGray"
    case lightGray = "CustomLightGray"
    case gray = "CustomGray"
    case opacity30White = "Opacity30White"
    case opacity20White = "Opacity20White"
    case background = "BackgroundColor"
    
    var color: Color {
        Color(self.rawValue)
    }
}
