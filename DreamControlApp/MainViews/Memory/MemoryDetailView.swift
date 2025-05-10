//
//  MemoryDetailView.swift
//  DreamControlApp
//
//  Created by Ainur on 08.05.2025.
//

import SwiftUI
import DataProvider
import PhotosUI

struct MemoryDetailView: View {
    @State var title = "Воспоминание"
    @State var storyContent = ""
    var dismiss: () -> Void
    private let characterLimit = 400

    @Environment(\.dataHandler) private var dataHandler

    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var selectedUIImage: UIImage? = nil

    var onSave: (String, String) -> Void
    let memory: DreamMemory
    init(onSave: @escaping (String, String) -> Void, memory: DreamMemory, dismiss: @escaping () -> Void) {
        self.onSave = onSave
        self.memory = memory
        self.dismiss = dismiss
        _title = State(initialValue: memory.dream.name)
        _storyContent = State(initialValue: memory.text)
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 100)
                .overlay(
                    HStack {
                        Image("CloudForDream")
                        VStack {
                            Text("Воспоминание")
                                .foregroundColor(Color("InactiveColor2"))
                                .bold()
                                .font(.custom("MontserratAlternates-Regular", size: 16))
                            Text(title)
                                .foregroundColor(.white)
                                .bold()
                                .font(.custom("MontserratAlternates-Regular", size: 28))
                        }
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    }
                )
            
            RoundedRectangle(cornerRadius: 20)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .foregroundColor(.white)
                .ignoresSafeArea(.all)
                    .overlay(
            ScrollView {                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            // сделать отмену сохранения
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(Color("PrimaryColor"))
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing)
                    }
                    VStack {
                        Text("Воспоминания о вашей мечте")
                            .foregroundColor(Color("TextColor"))
                            .bold()
                            .font(.custom("MontserratAlternates-Regular", size: 16))
                        ZStack {
                            // Контейнер с рамкой
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                            
                            // Контент внутри рамки
                            TextField("Напишите воспоминания о мечте...", text: $storyContent, axis: .vertical)
                                .font(.custom("MontserratAlternates-Regular", size: 16))
                                .padding(16) // внутренние отступы
                                .background(Color.clear) // убираем фон, чтобы не перекрывал рамку
                                .onChange(of: storyContent) { newValue in
                                    if newValue.count > characterLimit {
                                        storyContent = String(newValue.prefix(characterLimit))
                                    }
                                }
                        }
                        .padding(.bottom)

                        Text("Фото на память")
                            .foregroundColor(Color("TextColor"))
                            .bold()
                            .font(.title3)
                        VStack {
                            HStack {
                                PhotosPicker(
                                    selection: $selectedPhoto,
                                    matching: .images,
                                    photoLibrary: .shared()
                                ) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 3
                                            )
                                            .background(Color.white)
                                            .frame(maxWidth: .infinity)
                                        
                                        if let image = selectedUIImage {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 150)
                                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                                .clipped()
                                        } else {
                                            Text("Добавить фото")
                                                .foregroundColor(Color("TextColor"))
                                                .font(.custom("MontserratAlternates-Regular", size: 16))
                                        }
                                    }
                                    .onChange(of: selectedPhoto) { newItem in
                                        Task {
                                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                                               let image = UIImage(data: data) {
                                                selectedUIImage = image
                                            }
                                        }
                                    }
                                }
                                .frame(height: 150)

                                
                                ZStack {
                                    // Контейнер с рамкой
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 3
                                        )
                                    Text("Добавить фото")
                                        .foregroundColor(Color("TextColor"))
                                        .font(.custom("MontserratAlternates-Regular", size: 16))
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .frame(height: 150)
                            
                            HStack {
                                ZStack {
                                    // Контейнер с рамкой
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 3
                                        )
                                    Text("Добавить фото")
                                        .foregroundColor(Color("TextColor"))
                                        .font(.custom("MontserratAlternates-Regular", size: 16))
                                        .multilineTextAlignment(.center)
                                }
                                ZStack {
                                    // Контейнер с рамкой
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 3
                                        )
                                    Text("Добавить фото")
                                        .foregroundColor(Color("TextColor"))
                                        .font(.custom("MontserratAlternates-Regular", size: 16))
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .frame(height: 150)
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                    Button(action: {
                        saveMemory()
                    }) {
                        Rectangle()
                            .foregroundColor(Color("PrimaryColor"))
                            .cornerRadius(100)
                            .frame(height: 50)
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                            .overlay(
                                Text("Сохранить")
                                    .font(.custom("MontserratAlternates-Regular", size: 22))
                                    .foregroundColor(.white)
                                    .bold()
                            )
                }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            })
                    .padding(.horizontal)
        }
    }
    
    
    private func saveMemory() {
        Task {
            // Обновляем значения
            memory.text = storyContent
            memory.photoNames = [] // <- сюда добавь имена фото, если у тебя есть механизм их выбора

            // Сохраняем через modelContext
            try? await dataHandler?.save()

            // Вызываем callback, если нужно
            onSave(storyContent, memory.dream.name)

            // Закрываем вью
            dismiss()

        }
    }
}



//#Preview {
//    MemoryDetailView(isPresented: .constant(true)) {_, _ in}
//}
