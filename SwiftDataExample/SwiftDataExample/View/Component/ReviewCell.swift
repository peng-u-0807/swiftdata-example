import SwiftUI

struct ReviewCell: View {
    
    let review: Review
    let selectReview: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    Text(review.placeName)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                    Text(review.content)
                        .font(.system(size: 14))
                        .lineSpacing(16)
                        .foregroundStyle(CustomColor.lightGray.color)
                        .padding(.bottom, 2)
                }
                .multilineTextAlignment(.leading)
                
                if !review.tagList.isEmpty {
                    TagChipHScrollView(tagList: review.tagList)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                selectReview()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 15, weight: .light))
                    .foregroundStyle(CustomColor.opacity30White.color)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 18)
        .padding(.bottom, 16)
        .background(CustomColor.opacity20White.color)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
