//
//  MorningSplash.swift
//  DreamControlApp
//
//  Created by Ainur on 15.10.2024.
//

import SwiftUI

struct MorningSplash: View {
    @State private var circleOffset = CGSize.zero
    @State private var circleOffset2 = CGSize.zero
    @State private var circleOffset3 = CGSize.zero
    @State private var circleOffset4 = CGSize.zero
    @State private var starOffset = CGSize.zero
    @State private var starOffset2 = CGSize.zero
    @State private var starOffset3 = CGSize.zero
    @State private var starOffset4 = CGSize.zero
    @State private var rotationCloudAngle: Double = 0

    @State private var isActive = false

    var body: some View {
        if isActive {
            CustomTabBar()
        } else {
            VStack {
                Spacer()
                
                ZStack {
                    Image("morningCircleSplash")
                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    Image("Cloud1")
                        .resizable()
                        .frame(width: 40, height: 30)
                        .offset(x: -30, y: -40)
                        .offset(circleOffset)
                        .animation(.easeInOut(duration: 2), value: circleOffset) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                circleOffset = CGSize(width: 70, height: -45)
                            }
                        }
                    Image("Cloud1")
                        .resizable()
                        .frame(width: 60, height: 50)
                        .offset(x: -60, y: 80)
                        .offset(circleOffset2)
                        .animation(.easeInOut(duration: 2), value: circleOffset2) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                circleOffset2 = CGSize(width: 35, height: 10)
                            }
                        }
                    Image("Cloud1")
                        .resizable()
                        .frame(width: 30, height: 22)
                        .offset(x: 40, y: -90)
                        .offset(circleOffset3)
                        .animation(.easeInOut(duration: 2), value: circleOffset3) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                circleOffset3 = CGSize(width: -80, height: -5)
                            }
                        }
                    Image("Cloud1")
                        .resizable()
                        .frame(width: 30, height: 22)
                        .offset(x: 40, y: 20)
                        .offset(circleOffset4)
                        .animation(.easeInOut(duration: 2), value: circleOffset4) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                circleOffset4 = CGSize(width: -10, height: 20)
                            }
                        }
                    
                    Image("StarWhite")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .offset(x: 55, y: -55)
                        .offset(starOffset)
                        .animation(.easeInOut(duration: 2), value: starOffset) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                starOffset = CGSize(width: -65, height: 5)
                            }
                        }
                    
                    Image("StarWhite")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .offset(x: -70, y: -30)
                        .offset(starOffset2)
                        .animation(.easeInOut(duration: 2), value: starOffset2) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                starOffset2 = CGSize(width: 65, height: 50)
                            }
                        }
                    
                    Image("StarWhite")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .offset(x: -20, y: -10)
                        .offset(starOffset3)
                        .animation(.easeInOut(duration: 2), value: starOffset3) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                starOffset3 = CGSize(width: 50, height: -25)
                            }
                        }
                    
                    Image("StarWhite")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .offset(x: -10, y: 60)
                        .offset(starOffset4)
                        .animation(.easeInOut(duration: 2), value: starOffset4) // Анимация перемещения
                        .onAppear {
                            withAnimation {
                                // Укажите здесь целевые координаты, например:
                                starOffset4 = CGSize(width: -70, height: -50)
                            }
                        }
                    
                    Image("IllustrationHome")
                        .resizable()
                        .scaledToFit() // Сохраняет пропорции изображения
                        .scaleEffect(x: -1, y: 1) // отразить по горизонтали
                        .frame(width: 100, height: 100)
                        .offset(x: 100, y: -10)
                        .rotationEffect(.degrees(rotationCloudAngle)) // Поворачиваем изображение
                        .onAppear {
                            withAnimation(
                                Animation.easeInOut(duration: 2)
                            ) {
                                rotationCloudAngle = 10
                            }
                        }
                }
                Text("Утро начинается \n не с кофе, а с мечтаний...")
                    .foregroundColor(Color("PrimaryColor"))
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
    MorningSplash()
}
