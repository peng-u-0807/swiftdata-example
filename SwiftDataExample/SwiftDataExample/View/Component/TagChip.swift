import SwiftUI

struct TagChip: View {
    
    let tag: Tag
    
    var body: some View {
        Text(tag.name)
            .font(.system(size: 13, weight: .medium))
            .foregroundStyle(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.from(tag.color))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

struct TagChipHScrollView: View {
    
    let tagList: [Tag]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 4) {
                ForEach(tagList, id: \.id) {
                    TagChip(tag: $0)
                }
            }
        }
    }
}
