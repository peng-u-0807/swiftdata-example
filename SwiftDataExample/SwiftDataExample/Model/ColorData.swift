import Foundation
import SwiftData

@Model
final class ColorData {
    var hue: CGFloat
    var saturation: CGFloat
    var brightness: CGFloat
    var opacity: CGFloat
    
    private init(
        hue: CGFloat,
        saturation: CGFloat,
        brightness: CGFloat,
        opacity: CGFloat
    ) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.opacity = opacity
    }
    
    static func random() -> Self {
        let hue = Double.random(in: 0...1)
        let saturation = Double.random(in: 0.4...0.6)
        let brightness = Double.random(in: 0.85...1.0)
        return .init(hue: hue, saturation: saturation, brightness: brightness, opacity: 0.35)
    }
}
