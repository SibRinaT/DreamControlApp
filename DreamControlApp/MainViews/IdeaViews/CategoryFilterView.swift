//
//  CategoryFilterView.swift
//  DreamControlApp
//
//  Created by Ainur on 05.05.2025.
//

import SwiftUI

struct CategoryFilterView: View {
    @Binding var selectedCategories: Set<String>
    let allCategories: [String]
    var onDismiss: () -> Void

    var body: some View {
        NavigationView {
            List {
                ForEach(allCategories, id: \.self) { category in
                    MultipleSelectionRow(title: category, isSelected: selectedCategories.contains(category)) {
                        if selectedCategories.contains(category) {
                            selectedCategories.remove(category)
                        } else {
                            selectedCategories.insert(category)
                        }
                    }
                }
            }
            .navigationTitle("Выбор категорий")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
                        onDismiss() // Закрытие и обновление идеи
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryFilterView(
        selectedCategories: .constant([]),
        allCategories: ["Спорт", "Музыка", "Кино"],
        onDismiss: {}
    )
}
