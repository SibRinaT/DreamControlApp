//
//  DaySplash.swift
//  DreamControlApp
//
//  Created by Ainur on 18.10.2024.
//

import SwiftUI

struct DaySplash: View {
    @State private var cloudOffset = CGSize.zero
    @State private var cloudOffset2 = CGSize.zero
    @State private var cloudOffset3 = CGSize.zero
    @State private var starOffset = CGSize.zero
    @State private var starOffset2 = CGSize.zero
    @State private var starOffset3 = CGSize.zero
    @State private var rotationCloudAngle: Double = 0

    @State private var isActive = false

    var body: some View {
        if isActive {
            CustomTabBar()
        } else {
            VStack {
                Spacer()
                ZStack {
                    Image("dayCircleSplash")
                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    Image("Cloud1")
                        .resizable()
                        .frame(width: 40, height: 30)
                        .offset(x: 75, y: -65)
                        .offset(cloudOffset)
                        .animation(.easeInOut(duration: 2), value: cloudOffset) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                cloudOffset = CGSize(width: 25, height: 70)
                            }
                        }
                    Image("Cloud1")
                        .resizable()
                        .frame(width: 40, height: 30)
                        .offset(x: 75, y: 65)
                        .offset(cloudOffset2)
                        .animation(.easeInOut(duration: 2), value: cloudOffset2) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                cloudOffset2 = CGSize(width: -35, height: -155)
                            }
                        }
                    Image("Cloud1")
                        .resizable()
                        .frame(width: 25, height: 20)
                        .offset(x: 10, y: -70)
                        .offset(cloudOffset3)
                        .animation(.easeInOut(duration: 2), value: cloudOffset3) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                cloudOffset3 = CGSize(width: -30, height: 165)
                            }
                        }
                    Image("StarWhite")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .offset(x: 30, y: -10)
                        .offset(starOffset)
                        .animation(.easeInOut(duration: 2), value: starOffset) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                starOffset = CGSize(width: -20, height: 10)
                            }
                        }
                    Image("StarWhite")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .offset(x: 30, y: -40)
                        .offset(starOffset2)
                        .animation(.easeInOut(duration: 2), value: starOffset2) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                starOffset2 = CGSize(width: -60, height: 20)
                            }
                        }
                    Image("StarWhite")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .offset(x: 30, y: 50)
                        .offset(starOffset3)
                        .animation(.easeInOut(duration: 2), value: starOffset3) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                starOffset3 = CGSize(width: -30, height: 10)
                            }
                        }
                    Image("IllustrationHome")
                        .resizable()
                        .scaledToFit() // Сохраняет пропорции изображения
                    //                    .scaleEffect(x: -1, y: 1) // отразить по горизонтали
                        .frame(width: 100, height: 100)
                        .offset(x: -100, y: 10)
                        .rotationEffect(.degrees(30)) // Поворот на 15 градусов
                        .rotationEffect(.degrees(rotationCloudAngle)) // Поворачиваем изображение
                        .onAppear {
                            withAnimation(
                                Animation.easeInOut(duration: 2)
                            ) {
                                rotationCloudAngle = -25 // Поворачиваем на 5 градусов
                            }
                        }
                    
                }
                Text("День - это время  действовать и мечтать!")
                    .foregroundColor(Color("SecondaryColor"))
                    .font(.custom("MontserratAlternates-Regular", size: 42))
                    .multilineTextAlignment(.center)
                
                Spacer()
                Image("FullLogo")
                    .padding(.bottom)
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation() {
                        self.isActive = true
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DaySplash()
}
