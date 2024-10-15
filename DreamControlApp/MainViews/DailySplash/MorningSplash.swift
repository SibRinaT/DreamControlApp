//
//  MorningSplash.swift
//  DreamControlApp
//
//  Created by Ainur on 15.10.2024.
//

import SwiftUI

struct MorningSplash: View {
    @State private var circleOffset = CGSize.zero

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
                                               circleOffset = CGSize(width: 70, height: -55)
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
