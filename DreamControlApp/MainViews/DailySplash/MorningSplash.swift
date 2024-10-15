//
//  MorningSplash.swift
//  DreamControlApp
//
//  Created by Ainur on 15.10.2024.
//

import SwiftUI

struct MorningSplash: View {
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Image("dayCircleSplash")
            }
            Text("Утро начинается \n не с кофе, а с мечтаний...")
                .foregroundColor(Color("PrimaryColor"))
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            
            Spacer()
            Image("FullLogo")
                .padding(.bottom)
        }
    }
}

#Preview {
    MorningSplash()
}
