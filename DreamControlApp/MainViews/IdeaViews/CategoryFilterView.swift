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
            VStack(alignment: .leading) {
                // Кастомный заголовок
                HStack {
                    Image("DCIcon")
                    Text("Идеи")
                        .font(.largeTitle)
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    Spacer()
                }
                .padding()

                // Основной список
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
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
                        onDismiss()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline) // Скрывает большой системный заголовок
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
