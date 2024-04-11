//
//  OTPModifier.swift
//  DreamControlApp
//
//  Created by Ainur on 11.04.2024.
//

import SwiftUI
import Combine

struct OtpModifer: ViewModifier {
    @Binding var pin : String
    
    func limitText() {
        if pin.count > 1 {
            self.pin = String(pin.suffix(1))
        }
    }
        
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText()}
            .frame(width: 32, height: 32)
            .background(Color.white)
            .background(
                Rectangle()
                    .stroke(Color.gray, lineWidth: 2)
            )
    }
}
