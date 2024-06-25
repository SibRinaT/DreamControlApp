//
//  DreamView.swift
//  DreamControlApp
//
//  Created by Ainur on 16.06.2024.
//
import SwiftUI

struct DreamView: View {
    @State private var buttons: [(name: String, image: String)] = []
    @State private var showingSheet = false
    @State private var newButtonName = ""
    @State private var selectedImage = "StarForDream"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("DCIcon")
                    Text("Мечтания")
                        .font(.largeTitle)
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    Spacer()
                }
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(buttons, id: \.name) { button in
                            Button(action: {}, label: {
                                HStack {
                                    Image(button.image)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.leading)
                                    VStack(alignment: .leading) {
                                        Text("Мечта")
                                            .foregroundColor(Color("InactiveColor2"))
                                            .font(.subheadline)
                                        Text(button.name)
                                            .font(.title)
                                            .padding(.top, 5)
                                    }
                                    .bold()
                                    Spacer()
                                }
                                .padding()
                                .frame(height: 85)
                                .background(Color("PrimaryColor"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            })
                        }
                        
                        Button(action: {
                            showingSheet = true
                        }, label: {
                            Rectangle()
                                .foregroundColor(.clear) // Прозрачный фон
                                .frame(height: 85)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            style: StrokeStyle(
                                                lineWidth: 2,
                                                dash: [15] // Длина штрихов и пробелов в пунктирной линии
                                            )
                                        )
                                        .foregroundColor(Color("PrimaryColor")) // Цвет обводки
                                )
                                .overlay(
                                    Text("Добавить мечту")
                                        .foregroundColor(Color("PrimaryColor"))
                                        .font(.largeTitle)
                                        .bold()
                                )
                        })
                    }
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showingSheet) {
                NewDreamView(newButtonName: $newButtonName, selectedImage: $selectedImage, showingSheet: $showingSheet) { name, image in
                    if !name.isEmpty {
                        buttons.append((name: name, image: image))
                    }
                }
            }
        }
    }
}

struct NewDreamView: View {
    @Binding var newButtonName: String
    @Binding var selectedImage: String
    @Binding var showingSheet: Bool
    var onSave: (String, String) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                InputFieldView(title: "Название мечты", placeholder: "Введите название", text: $newButtonName)
                    .padding()
                
                Text("Выберите изображение")
                    .font(.headline)
                    .padding()
                
                HStack(spacing: 20) {
                    Image("StarForDream")
                        .onTapGesture {
                            selectedImage = "StarForDream"
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedImage == "StarForDream" ? Color("PrimaryColor") : Color.clear, lineWidth: 2)
                        )
                    
                    Image("CloudForDream")
                        .onTapGesture {
                            selectedImage = "CloudForDream"
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedImage == "CloudForDream" ? Color("PrimaryColor") : Color.clear, lineWidth: 2)
                        )
                    
                    Image("Cloud2ForDream")
                        .onTapGesture {
                            selectedImage = "Cloud2ForDream"
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedImage == "Cloud2ForDream" ? Color("PrimaryColor") : Color.clear, lineWidth: 2)
                        )
                }
                .padding()
                
                Button("Сохранить") {
                    onSave(newButtonName, selectedImage)
                    newButtonName = ""
                    selectedImage = "StarForDream"
                    showingSheet = false
                }
                .padding()
                
                Button("Отмена") {
                    showingSheet = false
                }
                .padding()
            }
            .navigationTitle("Новая мечта")
        }
    }
}

#Preview {
    DreamView()
}
