//
//  MultipleSelectionRow.swift
//  DreamControlApp
//
//  Created by Ainur on 05.05.2025.
//

import SwiftUI

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    MultipleSelectionRow(title: "dsadsad", isSelected: true, action: {})
}
