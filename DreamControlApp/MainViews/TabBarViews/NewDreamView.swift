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
            Text("Новая мечта")
                .font(.title)
                .bold()
                .padding()
                .padding(.leading)
            
            InputFieldView(title: "Название мечты", placeholder: "Введите название", text: $newButtonName)
                .padding()
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
            
            if newButtonName.count == 0 || newButtonName.count > 12 {
                Button("Сохранить") {
                    if !newButtonName.isEmpty {
                        saveNewDream(newButtonName, selectedImage)
                        
                    }
                }
                .disabled(true)
                .padding()
            } else {
                Button("Сохранить") {
                    if !newButtonName.isEmpty {
                        saveNewDream(newButtonName, selectedImage)
                    }
                }
                .foregroundColor(Color("PrimaryColor"))
                .padding()
            }
            
            Button("Отмена") {
                showingSheet = false
            }
            .foregroundColor(Color("PrimaryColor"))
            .padding()
        }
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


