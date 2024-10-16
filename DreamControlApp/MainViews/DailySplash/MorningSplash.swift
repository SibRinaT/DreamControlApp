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

    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Image("dayCircleSplash")
                    .shadow(radius: 10)
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
                    .frame(width: 30, height: 25)
                    .offset(x: 40, y: 20)
                    .offset(circleOffset4)
                                       .animation(.easeInOut(duration: 2), value: circleOffset4) // Анимация перемещения
                                       .onAppear {
                                           withAnimation {
                                               // Укажите здесь целевые координаты, например:
                                               circleOffset4 = CGSize(width: -10, height: 20)
                                           }
                                       }
            }
            Text("Утро начинается \n не с кофе, а с мечтаний...")
                .foregroundColor(Color("PrimaryColor"))
                .font(.custom("Iowan Old Style", size: 42))
                .multilineTextAlignment(.center)
            
            Spacer()
            Image("FullLogo")
                .padding(.bottom)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MorningSplash()
}
