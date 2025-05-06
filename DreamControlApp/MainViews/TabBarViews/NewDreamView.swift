//
//  NewDreamView.swift
//  DreamControlApp
//
//  Created by Ainur on 07.11.2024.
//

import SwiftUI
import DataProvider

struct NewDreamView: View {
    @Environment(\.dataHandler) private var dataHandler
    @Binding var newButtonName: String
    @Binding var selectedImage: String
    @Binding var showingSheet: Bool
    @State private var selectedDream: Dream? // Добавлено для хранения созданной мечты
    var onSave: (Dream) -> Void

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("DCIcon")
                    Text("Новая мечта")
                        .font(.largeTitle)
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    Spacer()
                }
            }
            .padding()
            .padding(.vertical)
            
            VStack {
                InputFieldView(title: "Название мечты", placeholder: "Введите название", text: $newButtonName)
                HStack {
                    if newButtonName.count == 0 || newButtonName.count > 12 {
                        Text("Символов: ")
                        Text("\(newButtonName.count)")
                            .foregroundColor(Color(.red))
                    } else {
                        Text("Символов: ")
                        Text("\(newButtonName.count)")
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }
                .font(.footnote)
            }
            
            Text("Выберите изображение")
                .font(.headline)
                .padding()
            
            HStack(spacing: 40) {
                VStack {
                    Image("StarForDream")
                    Text("Звезда")
                        .font(.caption2)
                        .foregroundColor(Color("TextColor"))
                        .bold()
                }
                .onTapGesture {
                    selectedImage = "StarForDream"
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedImage == "StarForDream" ? Color("PrimaryColor") : Color.clear, lineWidth: 2)
                )
                
                VStack {
                    Image("CloudForDream")
                    Text("Облако")
                        .font(.caption2)
                        .foregroundColor(Color("TextColor"))
                        .bold()
                }
                .onTapGesture {
                    selectedImage = "CloudForDream"
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedImage == "CloudForDream" ? Color("PrimaryColor") : Color.clear, lineWidth: 2)
                )
                VStack {
                    Image("Cloud2ForDream")
                    Text("2 облака")
                        .font(.caption2)
                        .foregroundColor(Color("TextColor"))
                        .bold()
                }
                .onTapGesture {
                    selectedImage = "Cloud2ForDream"
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedImage == "Cloud2ForDream" ? Color("PrimaryColor") : Color.clear, lineWidth: 2)
                )
            }
            .padding()
            
            Spacer()
            
            VStack {
                Group {
                    if newButtonName.count == 0 || newButtonName.count > 12 {
                        Rectangle()
                            .foregroundColor(Color("PrimaryColor").opacity(0.5))
                            .cornerRadius(100)
                            .frame(width: 135, height: 50)
                            .shadow(color: Color.black.opacity(0.15), radius: 10)
                            .overlay(
                                Text("Сохранить")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                            )
                            .padding()
                    } else {
                        Rectangle()
                            .foregroundColor(Color("PrimaryColor"))
                            .cornerRadius(100)
                            .frame(height: 50)
                            .shadow(color: Color.black.opacity(0.15), radius: 10)
                            .overlay(
                                Text("Сохранить")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                            )
                            .onTapGesture {
                                saveNewDream(newButtonName, selectedImage)
                            }
                    }
                }
                Rectangle()
                    .foregroundColor(Color("PrimaryColor"))
                    .cornerRadius(100)
                    .frame(height: 50)
                    .shadow(color: Color.black.opacity(0.15), radius: 10)
                    .overlay(
                        Text("Отмена")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                    )
                    .onTapGesture {
                        showingSheet = false
                    }
            }
            .padding(.horizontal)
            .padding()
        }
        Spacer()
    }
    
    private func saveNewDream(_ name: String, _ image: String) {
        Task {
            let newDream = Dream(id: UUID(), name: name, image: image, stories: [])
            await dataHandler?.new(dream: newDream)
            onSave(newDream)
            newButtonName = ""
            selectedImage = "StarForDream"
            showingSheet = false
        }
    }
}

#Preview {
    NewDreamView(
        newButtonName: .constant("Мечта"),
        selectedImage: .constant("StarForDream"),
        showingSheet: .constant(true),
        onSave: { dream in
            print("Preview onSave: \(dream.name)")
        }
    )
}
