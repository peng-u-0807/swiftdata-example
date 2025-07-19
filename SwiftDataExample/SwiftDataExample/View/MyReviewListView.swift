import SwiftUI

struct MyReviewListView: View {
    
    @Bindable private var viewModel: ViewModel = .init()
    @State private var selectedReview: Review?
    
    init() {}
    
    var body: some View {
        let showDeleteAlert: Binding<Bool> = .init(
            get: { self.selectedReview != nil },
            set: { _ in self.selectedReview = nil }
        )
        
        NavigationStack {
            VStack(spacing: 0) {
                customNavigationBar
                if viewModel.reviewList.isEmpty {
                    EmptyDataView(label: "작성한 리뷰가 없습니다")
                } else {
                    ScrollView(.vertical) {
                        ForEach(viewModel.reviewList, id: \.id) { review in
                            ReviewCell(review: review) {
                                selectedReview = review
                            }
                        }
                    }
                    .padding(.top, 12)
                    .padding(.horizontal, 16)
                }
                HStack(spacing: 6) {
                    NavigationLinkButton(
                        button: .default,
                        label: "태그 편집",
                        backgroundColor: CustomColor.gray.color
                    ) {
                        TagListView(
                            displayMode: .edit,
                            tagList: viewModel.tagList,
                            confirmSelection: { tagSet in
                                viewModel.deleteTagList(tagSet)
                            }
                        )
                    }
                    NavigationLinkButton(
                        button: .default,
                        label: "리뷰 작성",
                        backgroundColor: CustomColor.blue.color
                    ) {
                        AddReviewView(tagList: viewModel.tagList) { review in
                            viewModel.saveReview(review)
                        } addTag: { tag in
                            viewModel.addNewTag(tag)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .background(CustomColor.background.color)
            .alert("리뷰를 삭제할까요?", isPresented: showDeleteAlert) {
                Button("취소", role: .cancel) {}
                Button(role: .destructive) {
                    if let review = selectedReview {
                        viewModel.deleteReview(review)
                    }
                } label: {
                    Text("삭제")
                }
            }
        }
    }
}

extension MyReviewListView {
    @ViewBuilder
    private var customNavigationBar: some View {
        HStack {
            Text("내 리뷰")
                .font(.system(size: 28, weight: .semibold))
            Spacer()
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 24)
        .padding(.top, 32)
        .padding(.bottom, 16)
    }
}

#Preview {
    MyReviewListView()
}
