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

    @State private var selectedPhotos: [PhotosPickerItem?] = [nil, nil, nil, nil]
    @State private var selectedUIImages: [UIImage?] = [nil, nil, nil, nil]

    var onSave: (String, String) -> Void
    let memory: DreamMemory

    init(onSave: @escaping (String, String) -> Void, memory: DreamMemory, dismiss: @escaping () -> Void) {
        self.onSave = onSave
        self.memory = memory
        self.dismiss = dismiss
        _title = State(initialValue: memory.dream.name)
        _storyContent = State(initialValue: memory.text)

        // Загружаем ранее сохранённые фото
        var loadedImages: [UIImage?] = [nil, nil, nil, nil]
        for i in 0..<4 {
            let key = "\(memory.id.uuidString)_img\(i)"
            if let data = UserDefaults.standard.data(forKey: key),
               let img = UIImage(data: data) {
                loadedImages[i] = img
            }
        }
        _selectedUIImages = State(initialValue: loadedImages)
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
                .shadow(color: Color.black.opacity(0.15), radius: 10)
                .foregroundColor(.white)
                .ignoresSafeArea()
                .overlay(
                    ScrollView {
                        VStack(spacing: 16) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color("PrimaryColor"))
                                        .padding(8)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                                .padding(.trailing)
                            }

                            Text("Воспоминания о вашей мечте")
                                .foregroundColor(Color("TextColor"))
                                .bold()
                                .font(.custom("MontserratAlternates-Regular", size: 16))

                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(LinearGradient(
                                        gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ), lineWidth: 3)

                                TextField("Напишите воспоминания о мечте...", text: $storyContent, axis: .vertical)
                                    .font(.custom("MontserratAlternates-Regular", size: 16))
                                    .padding(16)
                                    .background(Color.clear)
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
                                .font(.custom("MontserratAlternates-Regular", size: 16))

                            ForEach(0..<2) { row in
                                VStack {
                                    ForEach(0..<2) { col in
                                        let index = row * 2 + col
                                        PhotosPicker(
                                            selection: Binding(get: {
                                                selectedPhotos[index]
                                            }, set: { newItem in
                                                selectedPhotos[index] = newItem
                                                if let newItem {
                                                    Task {
                                                        if let data = try? await newItem.loadTransferable(type: Data.self),
                                                           let image = UIImage(data: data) {
                                                            selectedUIImages[index] = image
                                                        }
                                                    }
                                                }
                                            }),
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

                                                if let image = selectedUIImages[index] {
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
                                        }
                                        .frame(height: 150)
                                    }
                                }
                            }

                            Button(action: {
                                saveMemory()
                            }) {
                                Rectangle()
                                    .foregroundColor(Color("PrimaryColor"))
                                    .cornerRadius(100)
                                    .frame(height: 50)
                                    .shadow(color: Color.black.opacity(0.15), radius: 10)
                                    .overlay(
                                        Text("Сохранить")
                                            .font(.custom("MontserratAlternates-Regular", size: 22))
                                            .foregroundColor(.white)
                                            .bold()
                                    )
                            }
                            .padding(.top)
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 50)
                    }
                    .padding()
                )
        }
    }

    private func saveMemory() {
        Task {
            memory.text = storyContent
            var savedPhotoNames: [String] = []

            for (index, image) in selectedUIImages.enumerated() {
                if let image = image, let data = image.jpegData(compressionQuality: 0.8) {
                    let key = "\(memory.id.uuidString)_img\(index)"
                    UserDefaults.standard.set(data, forKey: key)
                    savedPhotoNames.append(key)
                }
            }

            memory.photoNames = savedPhotoNames

            try? await dataHandler?.save()

            onSave(storyContent, memory.dream.name)
            dismiss()
        }
    }
}




//#Preview {
//    MemoryDetailView(isPresented: .constant(true)) {_, _ in}
//}
