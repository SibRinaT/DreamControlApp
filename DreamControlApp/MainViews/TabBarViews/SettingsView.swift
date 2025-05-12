//
//  SettingsView.swift
//  DreamControlApp
//
//  Created by Ainur on 20.06.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isAnimating") private var isAnimating: Bool = false
    @Binding var selectedTab: Int
    @AppStorage("showDeleteConfirmations") private var showDeleteConfirmations: Bool = true
    @AppStorage("userName") private var savedName: String = ""

    var body: some View {
        VStack {
            HStack {
                Image("DCIcon")
                Text("Настройки")
                    .font(.custom("MontserratAlternates-Regular", size: 32))
                    .foregroundColor(Color("PrimaryColor"))
                    .bold()
                Spacer()
            }
            
            ScrollView {
                Toggle(isOn: $isAnimating) {
                    Text("Включить анимацию")
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                }
                .toggleStyle(YellowToggle())

                Toggle(isOn: $showDeleteConfirmations) {
                    Text("Показывать окно подтверждения")
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                }
                .toggleStyle(YellowToggle())
                
                VStack(alignment: .leading) {
                    Text("Имя пользователя")
                        .foregroundColor(Color("TextColor"))
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                    ZStack {
                        Group {
                            Capsule()
                                .stroke(Color("PrimaryColor"), lineWidth: 1)
                                .background(Color.clear)
                                .frame(width: 302, height: 40)
                            TextField("Введите имя", text: Binding(
                                get: { savedName },
                                set: { newValue in
                                    if newValue.count <= 10 {
                                        savedName = newValue
                                    } else {
                                        savedName = String(newValue.prefix(10))
                                    }
                                }
                            ))
                            .foregroundColor(Color("TextColor"))
                            .font(.custom("MontserratAlternates-Regular", size: 16))
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .textFieldStyle(PlainTextFieldStyle())
                            .autocapitalization(.none) // Отключить автоматическое изменение раскладки
                            .frame(width: 302, height: 40)
                        }
                    }
                }
                .padding(.vertical)
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    SettingsView()
//}
