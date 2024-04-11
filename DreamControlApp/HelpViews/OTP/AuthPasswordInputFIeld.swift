//
//  AuthPasswordInputFIeld.swift
//  DreamControlApp
//
//  Created by Ainur on 11.04.2024.
//

import SwiftUI

struct AuthPasswordInputFIeld: View {
    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour, pinFive, pinSix
    }
    
    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""

    var completionHandler: ((String) -> ())?
    
    var body: some View {
        HStack {
            Image("AuthCircle")
                .overlay(
                    TextField("", text: $pinOne)
                        .background(Color("InactiveColor")) // Установка прозрачности
                        .modifier(OtpModifer(pin:$pinOne))
                        .onChange(of:pinOne) { newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinTwo
                            }
                            sendPin()
                        }
                        .focused($pinFocusState, equals: .pinOne)
                )
            Image("AuthCircle")
                .overlay(
                    TextField("", text: $pinTwo)
                        .modifier(OtpModifer(pin:$pinOne))
                        .onChange(of:pinOne) { newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinTwo
                            }
                            sendPin()
                        }
                        .focused($pinFocusState, equals: .pinOne)              
                )
            Image("AuthCircle")
                .overlay(
                    TextField("", text: $pinThree)
                        .modifier(OtpModifer(pin:$pinOne))
                        .onChange(of:pinOne) { newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinTwo
                            }
                            sendPin()
                        }
                        .focused($pinFocusState, equals: .pinOne)               
                )
            Image("AuthCircle")
                .overlay(
                    TextField("", text: $pinFour)
                        .modifier(OtpModifer(pin:$pinOne))
                        .onChange(of:pinOne) { newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinTwo
                            }
                            sendPin()
                        }
                        .focused($pinFocusState, equals: .pinOne)
                )
        }
    }
    func sendPin() {
        let pin = [pinOne, pinTwo, pinThree, pinFour].joined()
        completionHandler?(pin)
    }
}

#Preview {
    AuthPasswordInputFIeld()
}