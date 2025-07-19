import SwiftUI

struct NavigationLinkButton<Destination: View>: View {
    
    let button: Size
    let label: String
    let backgroundColor: Color
    var width: CGFloat? = nil
    let destination: () -> Destination
    
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            RectangleWithLabel(
                button: button,
                label: label,
                backgroundColor: backgroundColor,
                width: width
            )
        }
    }
}

struct RectangleButton: View {
    
    let button: Size
    let label: String
    let backgroundColor: Color
    var width: CGFloat? = nil
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            RectangleWithLabel(
                button: button,
                label: label,
                backgroundColor: backgroundColor,
                width: width
            )
        }
        .buttonStyle(.borderless)
    }
}

private struct RectangleWithLabel: View {
    
    let button: Size
    let label: String
    let backgroundColor: Color
    var width: CGFloat? = nil
    
    var body: some View {
        Text(label)
            .font(.system(size: button.fontSize, weight: .medium))
            .foregroundStyle(.white)
            .padding(.vertical, button.verticalPadding)
            .frame(maxWidth: width ?? .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: button.cornerRadius))
    }
}

enum Size {
    case small
    case `default`
    
    var fontSize: CGFloat {
        switch self {
        case .small: 14
        case .default: 16
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .small: 8
        case .default: 12
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .small: 12
        case .default: 16
        }
    }
}
