//
//  DaySplash.swift
//  DreamControlApp
//
//  Created by Ainur on 18.10.2024.
//

import SwiftUI

struct DaySplash: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("dayCircleSplash")
                    .shadow(radius: 10)
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
