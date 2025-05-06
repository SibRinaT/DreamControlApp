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
            VStack(alignment: .leading, spacing: 0) {
                // Кастомный заголовок
                HStack {
                    Image("DCIcon")
                    Text("Категории идей")
                        .font(.largeTitle)
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    Spacer()
                }
                .padding()

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(allCategories, id: \.self) { category in
                            // Оборачиваем в кнопку, чтобы гарантировать обновление
                            Button(action: {
                                if selectedCategories.contains(category) {
                                    selectedCategories.remove(category)
                                } else {
                                    selectedCategories.insert(category)
                                }
                            }) {
                                CategoryRowView(
                                    title: category,
                                    isSelected: selectedCategories.contains(category)
                                )
                            }
                            .buttonStyle(PlainButtonStyle()) // Убираем анимации кнопки по умолчанию
                        }
                    }
                }
            }
            .background(Color.white.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
                        onDismiss()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
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
