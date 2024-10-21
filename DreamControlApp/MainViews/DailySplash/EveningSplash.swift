//
//  NightSplash.swift
//  DreamControlApp
//
//  Created by Ainur on 20.10.2024.
//

import SwiftUI

struct EveningSplash: View {
    @State private var cloudOffset = CGSize.zero
    @State private var cloudOffset2 = CGSize.zero
    @State private var cloudOffset3 = CGSize.zero
    @State private var cloudOffset4 = CGSize.zero
    @State private var starOffset = CGSize.zero
    @State private var starOffset2 = CGSize.zero
    @State private var starOffset3 = CGSize.zero
    @State private var cloudScale: CGFloat = 1.0 // Добавляем состояние для масштабирования

    @State private var rotationCloudAngle: Double = 0
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("eveningCircleSplash")
                    .shadow(radius: 10)
                Image("Cloud1")
                    .resizable()
                    .frame(width: 40, height: 30)
                    .offset(x: 75, y: -65)
                    .offset(cloudOffset)
                                       .animation(.easeInOut(duration: 2), value: cloudOffset) // Анимация перемещения
                                       .onAppear {
                                           withAnimation {
                                               // Укажите здесь целевые координаты, например:
                                               cloudOffset = CGSize(width: -50, height: 100)
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
                                               cloudOffset2 = CGSize(width: -140, height: 10)
                                           }
                                       }
                Image("Cloud1")
                    .resizable()
                    .frame(width: 25, height: 20)
                    .offset(x: 70, y: -75)
                    .offset(cloudOffset3)
                                       .animation(.easeInOut(duration: 2), value: cloudOffset3) // Анимация перемещения
                                       .onAppear {
                                           withAnimation {
                                               // Укажите здесь целевые координаты, например:
                                               cloudOffset3 = CGSize(width: -60, height: 0)
                                           }
                                       }
                Image("Cloud1")
                    .resizable()
                    .frame(width: 40, height: 30)
                    .offset(x: -60, y: 20)
                    .offset(cloudOffset4)
                    .scaleEffect(cloudScale)
                           .animation(.easeInOut(duration: 2), value: cloudOffset4) // Анимация для перемещения
                           .animation(.easeInOut(duration: 2), value: cloudScale)
                                       .onAppear {
                                           withAnimation {
                                               cloudOffset4 = CGSize(width: 35, height: -35)
                                               cloudScale = 0.6
                                           }
                                       }
                Image("StarWhite")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .offset(x: 30, y: -5)
                    .offset(starOffset)
                                       .animation(.easeInOut(duration: 2), value: starOffset) // Анимация перемещения
                                       .onAppear {
                                           withAnimation {
                                               starOffset = CGSize(width: 72, height: 0)
                                           }
                                       }
                Image("StarWhite")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .offset(x: 0, y: 60)
                    .offset(starOffset2)
                                       .animation(.easeInOut(duration: 2), value: starOffset2) // Анимация перемещения
                                       .onAppear {
                                           withAnimation {
                                               starOffset2 = CGSize(width: 70, height: 0)
                                           }
                                       }
            }
            Text("Перед сном самое время помечтать")
                .foregroundColor(Color("SuccessColor"))
                .font(.custom("Iowan Old Style", size: 42))
                .multilineTextAlignment(.center)
            
            Spacer()
            Image("FullLogo")
                .padding(.bottom)
        }
        .padding(.horizontal)    }
}

#Preview {
    EveningSplash()
}
