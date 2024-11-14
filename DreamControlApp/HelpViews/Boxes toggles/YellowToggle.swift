//
//  YellowToggle.swift
//  DreamControlApp
//
//  Created by Ainur on 13.11.2024.
//

import SwiftUI

struct YellowToggle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.title2)
                .foregroundColor(Color(.black))
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 20)
                .fill(configuration.isOn ? Color.yellow : Color.gray.opacity(0.3))
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .padding(3)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

//#Preview {
//    YellowToggle() as! any View
//}
