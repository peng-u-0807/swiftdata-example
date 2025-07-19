import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    let placeholder: String
    var label: String? = nil
    var enableMultiline: Bool = false
    let textField: TextFieldType
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let label = label {
                Text(label)
                    .font(.system(size: 13))
                    .foregroundStyle(CustomColor.lightGray.color)
                    .padding(.horizontal, 12)
            }
            HStack(alignment: .top, spacing: 8) {
                Group {
                    if enableMultiline {
                        TextField(
                            "TextField",
                            text: $text,
                            prompt: placeholderView,
                            axis: .vertical
                        )
                    } else {
                        TextField(
                            "TextField",
                            text: $text,
                            prompt: placeholderView
                        )
                    }
                }
                .font(.system(size: 15))
                .foregroundStyle(.white)
                .frame(height: enableMultiline ? 200 : nil, alignment: .top)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .multilineTextAlignment(.leading)
                .focused($isFocused)
                .onSubmit {
                    if !enableMultiline {
                        isFocused = false
                    }
                }
                
                if isFocused {
                    Button {
                        isFocused = false
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                }
            }
            .padding(.horizontal, textField.horizontalPadding)
            .padding(.vertical, textField.verticalPadding)
            .background(CustomColor.opacity30White.color)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    @ViewBuilder
    private var placeholderView: Text {
        Text(placeholder)
            .font(.system(size: 15))
            .foregroundStyle(CustomColor.opacity30White.color)
    }
}

extension CustomTextField {
    enum TextFieldType {
        case slim
        case `default`
        
        var horizontalPadding: CGFloat {
            switch self {
            case .slim: 14
            case .default: 20
            }
        }
        
        var verticalPadding: CGFloat {
            switch self {
            case .slim: 12
            case .default: 16
            }
        }
    }
}
