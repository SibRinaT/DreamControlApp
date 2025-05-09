//
//  IdeasView.swift
//  DreamControlApp
//
//  Created by Ainur on 20.06.2024.
//

import SwiftUI
import DataProvider
import SwiftData

struct IdeasView: View {
    @State private var idea: String = "Выучить новый язык"
    @EnvironmentObject var ideasViewModel: IdeasViewModel  // Инициализируем и используем @StateObject
    @State private var dragOffset: CGSize = .zero
    @State private var rectangleColor: Color = .white
    @State private var showFavorites = false
    @Binding var selectedTab: Int
    @State private var selectedCategories: Set<String> = []
    @State private var showCategorySheet = false

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("DCIcon")
                    Text("Идеи")
                        .font(.largeTitle)
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    Spacer()
                }
            }
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(rectangleColor)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    .frame(height: 300)
                    .padding(.horizontal)
                    .offset(x: dragOffset.width, y: dragOffset.height * 0.1) // небольшое смещение по y
                    .rotationEffect(.degrees(Double(dragOffset.width) / 15))
                    .animation(.easeInOut(duration: 0.6), value: rectangleColor) // Плавный переход цвета
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation
                                if dragOffset.width > 0 {
                                    rectangleColor = Color("SuccessColor")
                                } else if dragOffset.width < 0 {
                                    rectangleColor = Color(.red)
                                }
                            }
                            .onEnded { value in
                                if value.translation.width > 100 {
                                    ideasViewModel.saveIdea(idea, isRightSwipe: true)
                                } else if value.translation.width < -100 {
                                    ideasViewModel.saveIdea(idea, isRightSwipe: false)
                                }
                                dragOffset = .zero
                                generateIdea()
                                rectangleColor = .white
                            }
                    )
                    .overlay(
                        VStack {
//                            Text("Название")
//                                .bold()
//                                .font(.title2)
//                                .padding(.bottom, 60)
//                                .offset(x: dragOffset.width, y: dragOffset.height * 0.1)
//                                .rotationEffect(.degrees(Double(dragOffset.width) / 15))
                            Text(idea)
                                .offset(x: dragOffset.width, y: dragOffset.height * 0.1)
                                .rotationEffect(.degrees(Double(dragOffset.width) / 15))
                                .font(.custom("MontserratAlternates-Regular", size: 24))
                                .padding(.horizontal, 30)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
//                                .padding(.bottom, 100)
                        }
                    )
                VStack {
                    Button(action: {
                        showCategorySheet = true
                    }) {
                        Rectangle()
                            .cornerRadius(16)
                            .frame(height: 50)
                            .gradientForeground(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")])
                            .overlay {
                                HStack {
                                    Image(systemName: "slider.horizontal.3")
                                        .foregroundColor(.white)
                                    Text("Фильтр категорий")
                                        .foregroundColor(.white)
                                        .font(.custom("MontserratAlternates-Regular", size: 14))
                                        .bold()
                                }
                            }
                    }
                    
                    .sheet(isPresented: $showCategorySheet) {
                        CategoryFilterView(
                            selectedCategories: $selectedCategories,
                            allCategories: ideasViewModel.ideas.map { $0.category }.uniqued(),
                            onDismiss: {
                                showCategorySheet = false
                                generateIdea() // Обновить идею после выбора
                            }
                        )
                    }
                }
                .padding()
                Spacer()
                
                VStack {
                    Button(action: {
                        showFavorites = true
                    }) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 100)
                            .foregroundColor(Color("PrimaryColor"))
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                            .overlay(
                                HStack {
                                    Text("Избранное")
                                        .bold()
                                        .font(.custom("MontserratAlternates-Regular", size: 18))
                                        .foregroundColor(.white)
                                }
                            )
                    }
                }
                .padding(.horizontal)
                .sheet(isPresented: $showFavorites) {
                    FavoritesIdeasView(ideasViewModel: ideasViewModel) // Открытие избранных идей
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            generateIdea() // При загрузке представления получаем случайную идею
        }
    }
    private func generateIdea() {
        idea = ideasViewModel.getRandomIdea(from: Array(selectedCategories)).text
    }
}




#Preview {
    IdeasView(selectedTab: .constant(0))
        .environmentObject(IdeasViewModel()) // Замените на мок если нужно
}
