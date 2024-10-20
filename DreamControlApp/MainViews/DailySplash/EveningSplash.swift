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
    @State private var starOffset = CGSize.zero
    @State private var starOffset2 = CGSize.zero
    @State private var starOffset3 = CGSize.zero

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
