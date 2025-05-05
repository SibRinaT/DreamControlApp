//
//  CategoryFilterView 2.swift
//  DreamControlApp
//
//  Created by Ainur on 05.05.2025.
//

import SwiftUI

struct CategoryFilterView: View {
    @Binding var selectedCategories: Set<String>
    let allCategories: [String]
    @Environment(\.dismiss) private var dismiss  // Добавлено для закрытия вьюшки

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
                        dismiss()  // Закрываем вьюшку
                    }
                }
            }
        }
    }
}

