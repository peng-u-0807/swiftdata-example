import SwiftUI

struct TagRowCell: View {
    
    let isSelected: Bool
    let tag: Tag
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20, weight: isSelected ? .regular : .light))
                    .foregroundStyle(isSelected ? .white : CustomColor.opacity30White.color)
                TagChip(tag: tag)
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
    }
}
