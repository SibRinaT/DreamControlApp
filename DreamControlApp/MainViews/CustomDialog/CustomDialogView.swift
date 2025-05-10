//
//  CustomDialogView.swift
//  DreamControlApp
//
//  Created by Ainur on 10.05.2025.
//

import SwiftUI
import DataProvider

struct CustomDialogView: View {
    let title: String
    let message: String
    let confirmationType: DreamView.ConfirmationType?
    let onConfirm: () -> Void
    let onCancel: () -> Void
    let onDisablePrompt: () -> Void
    
    @State private var isChecked = false

    var body: some View {
        Color.clear
            .ignoresSafeArea()
            .overlay(
                VStack(spacing: 20) {
                    Text(title)
                        .font(.custom("MontserratAlternates-Regular", size: 18))
                        .foregroundColor(.yellow)
                        .multilineTextAlignment(.center)

                    Text(message)
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                        .foregroundColor(.yellow)
                        .multilineTextAlignment(.center)

                    HStack {
                        Button("Нет") {
                            onCancel()
                        }
                        .font(.custom("MontserratAlternates-Regular", size: 16))
                        .foregroundColor(.yellow)

                        Spacer()

                        Button("Да") {
                            onConfirm()
                        }
                        .font(.custom("MontserratAlternates-Regular", size: 16))
                        .foregroundColor(.yellow)
                    }

                    Button(action: {
                                       isChecked.toggle()
                                       onDisablePrompt()
                                   }) {
                                       Label(
                                           "Больше не спрашивать",
                                           systemImage: isChecked ? "checkmark.square.fill" : "square"
                                       )
                                       .foregroundColor(.yellow)
                                       .font(.custom("MontserratAlternates-Regular", size: 14))
                                   }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .padding(40)
            )
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
    }
}


//#Preview {
//    CustomDialogView()
//}
