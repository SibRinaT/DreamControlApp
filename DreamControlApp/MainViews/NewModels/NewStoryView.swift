//
//  NewStoryView.swift
//  DreamControlApp
//
//  Created by Ainur on 10.09.2024.
//

import SwiftUI

struct NewStoryView: View {
    @Environment(\.dismiss) var dismiss // Для закрытия окна
    @State private var storyTitle: String = ""
    @State private var storyContent: String = ""

    var onSave: (String, String) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Название истории")) {
                    TextField("Введите название", text: $storyTitle)
                }

                Section(header: Text("Содержание истории")) {
                    TextField("Введите содержание", text: $storyContent)
                }
            }
            .navigationTitle("Новая история")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отмена") {
                        dismiss() // Закрыть окно без сохранения
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        onSave(storyTitle, storyContent)
                        dismiss() // Закрыть окно после сохранения
                    }
                    .disabled(storyTitle.isEmpty || storyContent.isEmpty) // Отключить кнопку, если поля пустые
                }
            }
        }
    }
}

#Preview {
    NewStoryView { _, _ in }
}
