import Foundation
import SwiftData

@Model
final class Tag: Identifiable {
    @Attribute(.unique) var id = UUID()
    var name: String
    var color: ColorData
    
    init(
        name: String,
        color: ColorData
    ) {
        self.name = name
        self.color = color
    }
}
