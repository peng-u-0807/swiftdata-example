import SwiftUI

extension Color {
    static func from(_ colorData: ColorData) -> Self {
        return Self(
            hue: colorData.hue,
            saturation: colorData.saturation,
            brightness: colorData.brightness,
            opacity: colorData.opacity
        )
    }
}
