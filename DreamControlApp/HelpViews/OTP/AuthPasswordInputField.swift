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
    @State private var isImageColored1 = false
    @State private var isImageColored2 = false
    @State private var isImageColored3 = false
    @State private var isImageColored4 = false


    var completionHandler: ((String) -> ())?
    
    var body: some View {
        HStack {
            Image(isImageColored1 ? "AuthCircleYellow" : "AuthCircle")
                .overlay(
                    TextField("", text: $pinOne)
                        .foregroundColor(Color("PrimaryColor"))
                        .modifier(OtpModifer(pin:$pinOne))
                        .onChange(of:pinOne) { newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinTwo
                                isImageColored1 = true
                            }
                            sendPin()
                        }
                        .focused($pinFocusState, equals: .pinOne)
                )
            
            Image(isImageColored2 ? "AuthCircleYellow" : "AuthCircle")
                .overlay(
                    TextField("", text:  $pinTwo)
                        .modifier(OtpModifer(pin:$pinTwo))
                        .onChange(of:pinTwo){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinThree
                            } else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinOne
                                    isImageColored2 = true
                                }
                            }
                            sendPin()
                        }
                        .focused($pinFocusState, equals: .pinTwo)
                    )
            
            Image(isImageColored3 ? "AuthCircleYellow" : "AuthCircle")
                .overlay(
                    TextField("", text:$pinThree)
                        .modifier(OtpModifer(pin:$pinThree))
                        .onChange(of:pinThree){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinFour
                            } else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinTwo
                                    isImageColored3 = true
                                }
                            }
                            sendPin()
                        }
                        .focused($pinFocusState, equals: .pinThree)
                )
            
            Image(isImageColored4 ? "AuthCircleYellow" : "AuthCircle")
                .overlay(
                    TextField("", text:$pinFour)
                        .modifier(OtpModifer(pin:$pinFour))
                        .onChange(of:pinFour){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinFive
                            } else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinThree
                                    isImageColored4 = true
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
