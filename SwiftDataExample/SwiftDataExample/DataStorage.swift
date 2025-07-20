import Foundation
import Observation
import SwiftData

@MainActor
@Observable final class DataStorage {
    private init() {
        let schema = Schema([Tag.self, Review.self])
        let config = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            allowsSave: true,
        )
        let container = try? ModelContainer(for: schema, configurations: config)
        container?.mainContext.autosaveEnabled = true
        self.container = container
        loadSavedData()
    }
    
    static private(set) var shared: DataStorage = .init()
    private var container: ModelContainer?
    
    var reviewList: [Review] {
        _reviewList.sorted(by: { $0.createdAt > $1.createdAt })
    }
    private var _reviewList: [Review] = []
    
    var tagList: [Tag] {
        _tagList.sorted(by: { $0.name < $1.name })
    }
    private var _tagList: [Tag] = []
    
    private func loadSavedData() {
        fetchTagList()
        fetchReviewList()
    }
    
    private func fetchReviewList() {
        guard let container = container else {
            return
        }
        var reviewFetchDescriptor = FetchDescriptor<Review>(
            sortBy: [.init(\.createdAt)]
        )
        reviewFetchDescriptor.includePendingChanges = true
        guard let reviewList = try? container.mainContext.fetch(reviewFetchDescriptor) else {
            return
        }
        _reviewList = reviewList
    }
    
    private func fetchTagList() {
        guard let container = container else {
            return
        }
        let tagFetchDescriptor = FetchDescriptor<Tag>(
            sortBy: [.init(\.name)]
        )
        guard let tagList = try? container.mainContext.fetch(tagFetchDescriptor) else {
            return
        }
        _tagList = tagList
    }
    
    func saveReview(_ review: Review) {
        guard let container = container else {
            return
        }
        container.mainContext.insert(review)
        try? container.mainContext.save()
        fetchReviewList()
    }
    
    func deleteReview(_ review: Review) {
        guard let container = container else {
            return
        }
        let targetId = review.id
        try? container.mainContext.delete(model: Review.self, where: #Predicate { $0.id == targetId })
        try? container.mainContext.save()
        fetchReviewList()
    }
    
    func addNewTag(_ tag: Tag) {
        guard let container = container else {
            return
        }
        container.mainContext.insert(tag)
        try? container.mainContext.save()
        _tagList.append(tag)
    }
    
    func deleteTagList(_ tagSet: Set<Tag>) {
        guard let container = container else {
            return
        }
        for tag in tagSet {
            let targetId = tag.id
            try? container.mainContext.delete(model: Tag.self, where: #Predicate { $0.id == targetId })
        }
        try? container.mainContext.save()
        _tagList.removeAll { tagSet.contains($0) }
        fetchReviewList()
    }
}
