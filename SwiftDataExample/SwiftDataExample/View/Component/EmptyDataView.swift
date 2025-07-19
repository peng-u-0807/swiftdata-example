import SwiftUI

struct EmptyDataView: View {
    
    let label: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(label)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(CustomColor.opacity30White.color)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
