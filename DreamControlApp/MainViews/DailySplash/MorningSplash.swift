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
            ZStack {
                Image("dayCircleSplash")
            }
            Text("Утро начинается \n не с кофе, а с мечтаний...")
                .foregroundColor(Color("PrimaryColor"))
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            
        }
    }
}

#Preview {
    MorningSplash()
}
