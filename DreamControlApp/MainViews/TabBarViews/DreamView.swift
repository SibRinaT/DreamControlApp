//
//  DreamView.swift
//  DreamControlApp
//
//  Created by Ainur on 16.06.2024.
//
import SwiftUI

struct DreamView: View {
    @State private var buttons: [(name: String, image: String)] = []
    @State private var showingAlert = false
    @State private var showingImagePicker = false
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
                            showingAlert = true
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
            .alert("Новая мечта", isPresented: $showingAlert) {
                VStack {
                    TextField("Введите название", text: $newButtonName)
                    Button("Выберите изображение") {
                        showingImagePicker = true
                    }
                    Button("Добавить") {
                        if !newButtonName.isEmpty {
                            buttons.append((name: newButtonName, image: selectedImage))
                            newButtonName = ""
                            selectedImage = "StarForDream"
                        }
                        showingAlert = false
                    }
                    Button("Отмена", role: .cancel) {
                        showingAlert = false
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
}

struct ImagePicker: View {
    @Binding var selectedImage: String
    
    var body: some View {
        VStack {
            Text("Выберите изображение")
                .font(.headline)
                .padding()
            
            HStack(spacing: 20) {
                Image("StarForDream")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        selectedImage = "StarForDream"
                    }
                Image("CloudForDream")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        selectedImage = "CloudForDream"
                    }
                Image("Cloud2ForDream")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        selectedImage = "Cloud2ForDream"
                    }
            }
            .padding()
            
            Button("Готово") {
                // Close the image picker
            }
            .padding()
        }
    }
}

#Preview {
    DreamView()
}
