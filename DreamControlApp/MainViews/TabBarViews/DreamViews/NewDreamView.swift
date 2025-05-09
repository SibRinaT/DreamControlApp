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
                        .font(.custom("MontserratAlternates-Regular", size: 32))
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    Spacer()
                    
                    Button(action: {
                                        showingSheet = false
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundColor(Color("PrimaryColor"))
                                            .padding(8)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                    }
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
                .font(.custom("MontserratAlternates-Regular", size: 14))
            }
            
            Text("Выберите изображение")
                .font(.custom("MontserratAlternates-Regular", size: 16))
                .bold()
                .padding()
            
            HStack(spacing: 40) {
                VStack {
                    Image("StarForDream")
                    Text("Звезда")
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                        .foregroundColor(Color("TextColor"))
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
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                        .foregroundColor(Color("TextColor"))
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
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                        .foregroundColor(Color("TextColor"))
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
                            .frame(height: 50)
                            .shadow(color: Color.black.opacity(0.15), radius: 10)
                            .overlay(
                                Text("Сохранить")
                                    .font(.custom("MontserratAlternates-Regular", size: 18))
                                    .foregroundColor(.white)
                                    .bold()
                            )
                    } else {
                        Rectangle()
                            .foregroundColor(Color("PrimaryColor"))
                            .cornerRadius(100)
                            .frame(height: 50)
                            .shadow(color: Color.black.opacity(0.15), radius: 10)
                            .overlay(
                                Text("Сохранить")
                                    .font(.custom("MontserratAlternates-Regular", size: 18))
                                    .foregroundColor(.white)
                                    .bold()
                            )
                            .onTapGesture {
                                saveNewDream(newButtonName, selectedImage)
                            }
                    }
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
