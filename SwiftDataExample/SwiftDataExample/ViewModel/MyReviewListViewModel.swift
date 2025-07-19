import Foundation

extension MyReviewListView {
    @MainActor
    @Observable final class ViewModel {
        init() {}
        
        var reviewList: [Review] {
            DataStorage.shared.reviewList
        }
        
        var tagList: [Tag] {
            DataStorage.shared.tagList
        }
        
        func saveReview(_ review: Review) {
            DataStorage.shared.saveReview(review)
        }
        
        func deleteReview(_ review: Review) {
            DataStorage.shared.deleteReview(review)
        }
        
        func addNewTag(_ tag: Tag) {
            DataStorage.shared.addNewTag(tag)
        }
        
        func deleteTagList(_ tagSet: Set<Tag>) {
            DataStorage.shared.deleteTagList(tagSet)
        }
    }
}
