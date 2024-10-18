//
//  DaySplash.swift
//  DreamControlApp
//
//  Created by Ainur on 18.10.2024.
//

import SwiftUI

struct DaySplash: View {
    @State private var cloudOffset = CGSize.zero

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
