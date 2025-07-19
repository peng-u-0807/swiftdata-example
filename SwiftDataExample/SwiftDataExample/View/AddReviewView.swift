import SwiftUI

struct AddReviewView: View {
    
    let tagList: [Tag]
    let save: (Review) -> Void
    let addTag: (Tag) -> Void
    
    @State private var placeName: String = ""
    @State private var reviewContent: String = ""
    @State private var selectedTagList: [Tag] = []
    
    @Environment(\.dismiss) private var dismiss
    
    private var disableSaveButton: Bool {
        placeName.isEmpty || reviewContent.isEmpty
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    CustomTextField(
                        text: $placeName,
                        placeholder: "장소의 이름을 입력해 주세요",
                        label: "장소명",
                        textField: .default
                    )
                    CustomTextField(
                        text: $reviewContent,
                        placeholder: "방문한 장소는 어땠나요?",
                        label: "리뷰 내용",
                        enableMultiline: true,
                        textField: .default
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        Text("태그")
                            .font(.system(size: 13))
                            .foregroundStyle(CustomColor.lightGray.color)
                            .padding(.horizontal, 12)
                        NavigationLink {
                            TagListView(
                                displayMode: .select,
                                tagList: tagList,
                                selectedTagList: selectedTagList
                            ) { newTag in
                                addTag(newTag)
                            } confirmSelection: { tagSet in
                                selectedTagList = Array(tagSet)
                            }
                        } label: {
                            Group {
                                if selectedTagList.isEmpty {
                                    Text("태그를 선택해 주세요")
                                        .font(.system(size: 15))
                                        .foregroundStyle(CustomColor.opacity30White.color)
                                } else {
                                    TagChipHScrollView(tagList: selectedTagList)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(CustomColor.opacity20White.color)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                .padding(.bottom, 12)
            }
            
            RectangleButton(
                button: .default,
                label: "저장",
                backgroundColor: disableSaveButton
                ? CustomColor.darkGray.color : CustomColor.blue.color
            ) {
                let newReview = Review(placeName: placeName, content: reviewContent, tagList: selectedTagList)
                save(newReview)
                dismiss()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
            .disabled(disableSaveButton)
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("리뷰 작성")
        .background(CustomColor.background.color)
    }
}
