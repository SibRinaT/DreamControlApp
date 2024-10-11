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
        VStack {
            HStack {
                Image("DCIcon")
                Text("Новая история")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("PrimaryColor"))
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            .padding(.bottom, 40)
            
            // Поле для ввода названия истории
            InputFieldView(title: "Название истории", placeholder: "Введите название", text: $storyTitle)
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("Описание истории")
                        .foregroundColor(Color("TextColor"))
                        .font(.custom("", size: 20)) // need to fix a font
                    Spacer()
                }
                
                // Поле для ввода описания истории
                ZStack {
                    Group {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(Color("PrimaryColor"), lineWidth: 3) // Граница прямоугольника
                            .background(Color.clear) // Прозрачный фон
                            .frame(width: 300, height: 200) // Размеры прямоугольника
                            .padding()
                        
                        TextField("Введите описание...", text: $storyContent, axis: .vertical)
                            .foregroundColor(Color("TextColor"))
                            .font(.custom("", size: 16)) // need to fix a font
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .textFieldStyle(PlainTextFieldStyle())
                            .autocapitalization(.none) // Отключить автоматическое изменение раскладки
                            .frame(height: 200)
                            .padding(.horizontal)
                    }
                }
                .font(.caption2)
                .textFieldStyle(.roundedBorder)
                
                // Кнопки "Сохранить" и "Отмена"
                VStack {
                    Button(action: {
                        // Логика для сохранения истории
                        onSave(storyTitle, storyContent)
                        dismiss() // Закрываем окно
                    }, label: {
                        Rectangle()
                            .foregroundColor(Color("PrimaryColor"))
                            .cornerRadius(100)
                            .frame(height: 70)
                            .shadow(radius: 1)
                            .overlay(
                                Text("Сохранить")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            )
                    })
                    .disabled(storyTitle.isEmpty || storyContent.isEmpty) // Отключить, если поля пустые
                    .padding(.bottom)
                    
                    Button(action: {
                        // Закрытие окна без сохранения
                        dismiss()
                    }, label: {
                        Rectangle()
                            .foregroundColor(Color("PrimaryColor"))
                            .cornerRadius(100)
                            .frame(height: 70)
                            .shadow(radius: 51)
                            .overlay(
                                Text("Отмена")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            )
                    })
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    NewStoryView{_, _ in }
}
