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

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("dayCircleSplash")
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
            }
            Text("День - это время  действовать и мечтать!")
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
    DaySplash()
}
