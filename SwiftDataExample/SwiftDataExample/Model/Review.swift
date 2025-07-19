import Foundation
import SwiftData

@Model
final class Review {
    @Attribute(.unique) var id = UUID()
    var createdAt: Date
    var placeName: String
    var content: String
    @Relationship(deleteRule: .nullify) var tagList: [Tag]
    
    init(
        placeName: String,
        content: String,
        tagList: [Tag]
    ) {
        self.createdAt = .now
        self.placeName = placeName
        self.content = content
        self.tagList = tagList
    }
}
