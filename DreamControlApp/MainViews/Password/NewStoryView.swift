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
    @State private var storyDescription: String = ""
    private let characterLimit = 200
    @State private var autoStory: Bool = false

    

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
                        
                        TextField("Введите описание...", text: $storyDescription, axis: .vertical)
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
                
                HStack {
                    Spacer()
                    Text("Количество: \(storyDescription.count)/200")
                        .onChange(of: storyDescription) { newValue in
                            if newValue.count > characterLimit {
                                storyDescription = String(newValue.prefix(characterLimit))
                            }
                        }
                    Spacer()
                }
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Переключаем состояние
                            autoStory.toggle()
                        }, label: {
                            HStack {
                                Circle()
                                    .strokeBorder(autoStory ? Color("Prem1") : Color.gray, lineWidth: 2)
                                    .background(Circle().fill(autoStory ? Color("Prem1") : Color.clear))
                                    .frame(width: 20, height: 20)
                                
                                Text("Авто-история")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .padding()
                            .background(Rectangle()
                                .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                                .cornerRadius(100)
                                .shadow(radius: 1))
                        })
                        Spacer()

                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                // Кнопки "Сохранить" и "Отмена"

                Spacer()
                HStack {
                    Button(action: {
                        // Логика для сохранения истории
                        onSave(storyTitle, storyDescription)
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
                    .disabled(storyTitle.isEmpty || storyDescription.isEmpty) // Отключить, если поля пустые
                    
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
