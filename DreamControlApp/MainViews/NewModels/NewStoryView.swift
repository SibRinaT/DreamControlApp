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
//    @State private var storyName = ""
//    @State private var storyDescription = ""
    
    var onSave: (String, String) -> Void

    var body: some View {
        VStack {
            HStack {
                Image("DCIcon")
                Text("Новая история")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("PrimaryColor"))
                Spacer()
            }
            .padding(.horizontal)
            
            InputFieldView(title: "Название истории", placeholder: "Введите название", text: $storyTitle)
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("Описание истории")
                        .foregroundColor(Color("TextColor"))
                        .font(.custom("", size: 20)) // need to fix a font
                    Spacer()
                    
                }
                ZStack {
                    Group {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(Color("PrimaryColor"), lineWidth: 3) // Граница прямоугольника
                            .background(Color.clear) // Прозрачный фон
                            .frame(width: 300, height: 200) // Размеры прямоугольника
                            .padding()
                        
                        //                                .stroke(Color("PrimaryColor"), lineWidth: 1)
                        //                                .background(Color.clear)
                        //                                .frame(width: 302, height: 200)
                        TextField("мама", text: $storyContent, axis: .vertical)
                            .foregroundColor(Color("TextColor"))
                            .font(.custom("", size: 16)) // need to fix a font
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .textFieldStyle(PlainTextFieldStyle())
                            .autocapitalization(.none) // Отключить автоматическое изменение раскладки
                            .frame(width: 302, height: 200)
                    }
                }
                .font(.caption2)
                .textFieldStyle(.roundedBorder)
            }
            Spacer()
                .padding(.bottom)
        }
    }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Отмена") {
//                        dismiss() // Закрыть окно без сохранения
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Сохранить") {
//                        onSave(storyTitle, storyContent)
//                        dismiss() // Закрыть окно после сохранения
//                    }
//                    .disabled(storyTitle.isEmpty || storyContent.isEmpty) // Отключить кнопку, если поля пустые
//                }
            }

#Preview {
    NewStoryView{_, _ in }
}
