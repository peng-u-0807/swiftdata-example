import SwiftUI

struct TagListView: View {
    
    let displayMode: DisplayMode
    let tagList: [Tag]
    var addTag: (Tag) -> Void = { _ in }
    var confirmSelection: (Set<Tag>) -> Void = { _ in }
    
    @State private var newTagName: String = ""
    @State private var selectedTagSet: Set<Tag>
    
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    private var disableAddTagButton: Bool {
        newTagName.isEmpty
    }
    
    init(
        displayMode: DisplayMode,
        tagList: [Tag],
        selectedTagList: [Tag] = [],
        addTag: @escaping (Tag) -> Void = { _ in },
        confirmSelection: @escaping (Set<Tag>) -> Void = { _ in }
    ) {
        self.displayMode = displayMode
        self.tagList = tagList
        self.addTag = addTag
        self.confirmSelection = confirmSelection
        selectedTagSet = .init(selectedTagList)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                if displayMode == .select {
                    HStack(spacing: 8) {
                        CustomTextField(
                            text: $newTagName,
                            placeholder: "추가할 태그를 입력해 주세요",
                            textField: .slim
                        )
                        .focused($isFocused)
                        
                        RectangleButton(
                            button: .small,
                            label: "추가",
                            backgroundColor: disableAddTagButton
                            ? CustomColor.darkGray.color : CustomColor.blue.color,
                            width: 60
                        ) {
                            let newTag = Tag(name: newTagName, color: .random())
                            addTag(newTag)
                            newTagName = ""
                            isFocused = false
                        }
                        .disabled(disableAddTagButton)
                    }
                    .padding(.bottom, 12)
                    .padding(.horizontal, 16)
                }
                if tagList.isEmpty {
                    EmptyDataView(label: "저장된 태그가 없습니다")
                } else {
                    ScrollView(.vertical) {
                        ForEach(tagList, id: \.id) { tag in
                            TagRowCell(isSelected: selectedTagSet.contains(tag), tag: tag) {
                                if selectedTagSet.contains(tag) {
                                    selectedTagSet.remove(tag)
                                } else {
                                    selectedTagSet.insert(tag)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, 12)
            
            RectangleButton(
                button: .default,
                label: displayMode.buttonLabel,
                backgroundColor: displayMode.buttonColor
            ) {
                confirmSelection(selectedTagSet)
                dismiss()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
        }
        .toolbarRole(.editor)
        .navigationTitle(displayMode.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .background(CustomColor.background.color)
    }
}

extension TagListView {
    enum DisplayMode {
        case edit
        case select
        
        var navigationTitle: String {
            switch self {
            case .edit: "태그 편집"
            case .select: "태그 선택"
            }
        }
        
        var buttonLabel: String {
            switch self {
            case .edit: "선택한 태그 삭제"
            case .select: "확인"
            }
        }
        
        var buttonColor: Color {
            switch self {
            case .edit: CustomColor.red.color
            case .select: CustomColor.blue.color
            }
        }
    }
}
