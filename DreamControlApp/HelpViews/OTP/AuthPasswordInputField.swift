//
//  AuthPasswordInputFIeld.swift
//  DreamControlApp
//
//  Created by Ainur on 11.04.2024.
//

import SwiftUI

struct AuthPasswordInputField: View {
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
                    TextField("", text:  $pinTwo)
                        .modifier(OtpModifer(pin:$pinTwo))
                        .onChange(of:pinTwo){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinThree
                            } else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinOne
                                }
                            }
                            sendPin()
                        }
                        .focused($pinFocusState, equals: .pinTwo)
                    )
            
            Image("AuthCircle")
                .overlay(
                    TextField("", text:$pinThree)
                        .modifier(OtpModifer(pin:$pinThree))
                        .onChange(of:pinThree){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinFour
                            } else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinTwo
                                }
                            }
                            sendPin()
                        }
                        .focused($pinFocusState, equals: .pinThree)
                )
            
            Image("AuthCircle")
                .overlay(
                    TextField("", text:$pinFour)
                        .modifier(OtpModifer(pin:$pinFour))
                        .onChange(of:pinFour){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinFive
                            } else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinThree
                                }
                            }
                            sendPin()
                        }
                        .focused($pinFocusState, equals: .pinFour)
                )
        }
    }
    func sendPin() {
        let pin = [pinOne, pinTwo, pinThree, pinFour].joined()
        completionHandler?(pin)
    }
}

#Preview {
    AuthPasswordInputField()
}
