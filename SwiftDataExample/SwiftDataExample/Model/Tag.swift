import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id = UUID()
    var name: String
    var color: ColorData
    @Relationship(inverse: \Review.tagList) var relatedReviewList: [Review]?
    
    init(
        name: String,
        color: ColorData
    ) {
        self.name = name
        self.color = color
        self.relatedReviewList = nil
    }
}
