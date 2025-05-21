//
//  DreamsCountView.swift
//  DreamControlApp
//
//  Created by Ainur on 19.06.2024.
//

import SwiftUI
import SwiftData
import DataProvider

struct DreamsCountView: View {
    @Environment(IdeasViewModel.self) private var ideasViewModel
    
    @State private var showFavorites = false
    @Binding var isAnimating: Bool
    @State private var rotateAmount: CGFloat = 5
    @Query(filter: #Predicate<Dream> { !$0.isArchived }) private var dreams: [Dream]
    @Binding var selectedTab: Int

    // Состояния для анимации
    @State private var cloudRotation: Double = 0
    @State private var starRotation: Double = 0

    var body: some View {
        HStack {
            ZStack {
                NavigationLink(destination: DreamView(selectedTab: $selectedTab)) {
                    Rectangle()
                        .frame(height: 60)
                        .foregroundColor(Color("PrimaryColor"))
                        .cornerRadius(10)
                        .overlay(
                            VStack {
                                Text("\(dreams.count)")
                                    .bold()
                                    .font(.custom("MontserratAlternates-Regular", size: 20))
                                    .foregroundColor(.white)
                                Text("Мечты")
                                    .bold()
                                    .font(.custom("MontserratAlternates-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                                .padding(.vertical)
                        )
                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                        .padding(.vertical, 20)
                        .padding(.horizontal)
                }

                // Анимация облаков
                cloudImage("CloudSmallImage", offset: CGSize(width: 57, height: 15))
                cloudImage("CloudImage", offset: CGSize(width: 75, height: -25))
                cloudImage("CloudSmallImage", offset: CGSize(width: -57, height: -15))
                cloudImage("CloudImage", offset: CGSize(width: -75, height: 20))
            }
            .frame(height: 100)

            ZStack {
                Button(action: {
                    showFavorites = true
                }) {
                    Rectangle()
                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                        .frame(height: 60)
                        .foregroundColor(Color("SuccessColor"))
                        .cornerRadius(10)
                        .overlay(
                            VStack {
                                Text("\(ideasViewModel.favoriteIdeas.count)")
                                    .bold()
                                    .font(.custom("MontserratAlternates-Regular", size: 20))
                                    .foregroundColor(.white)
                                Text("Идей")
                                    .bold()
                                    .font(.custom("MontserratAlternates-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                                .padding(.vertical)
                        )
                        .padding(.horizontal)
                }
                .sheet(isPresented: $showFavorites) {
                    FavoritesIdeasView(ideasViewModel: ideasViewModel)
                }

                // Анимация звёзд
                starImage("StarSmallImage", offset: CGSize(width: -50, height: 18))
                starImage("StarImage", offset: CGSize(width: -75, height: -25))
                starImage("StarSmallImage", offset: CGSize(width: 57, height: -10))
                starImage("StarImage", offset: CGSize(width: 75, height: 25))
            }
            .frame(height: 100)
        }
        .onAppear {
            startAnimationsIfNeeded()
        }
        .onChange(of: isAnimating) { _ in
            startAnimationsIfNeeded()
        }
    }

    // MARK: - Анимации

    private func startAnimationsIfNeeded() {
        if isAnimating {
            withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                cloudRotation = Double(rotateAmount)
                starRotation = -Double(rotateAmount)
            }
        } else {
            cloudRotation = 0
            starRotation = 0
        }
    }

    private func cloudImage(_ name: String, offset: CGSize) -> some View {
        Image(name)
            .offset(offset)
            .rotationEffect(.degrees(cloudRotation))
    }

    private func starImage(_ name: String, offset: CGSize) -> some View {
        Image(name)
            .offset(offset)
            .rotationEffect(.degrees(starRotation))
    }
}



//#Preview {
//    NavigationView {
//        DreamsCountView(isAnimating: .constant(true))
//            .environment(\.dataHandler, DataHandler(modelContainer: DataProvider.shared.sharedModelContainer,
//                                                    mainActor: true))      .environmentObject(IdeasViewModel())
//    }
//}
