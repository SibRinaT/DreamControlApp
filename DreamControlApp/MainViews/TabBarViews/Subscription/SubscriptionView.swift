//
//  SubscriptionView.swift
//  DreamControlApp
//
//  Created by Ainur on 17.06.2024.
//

import SwiftUI

struct SubscriptionView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showConfirmation = false
    @State private var showFailureAlert = false
    
    var body: some View {
        VStack {
            Text("Подписка")
                .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                .font(.custom("MontserratAlternates-Regular", size: 56))
                .bold()
            VStack(alignment: .leading)  {
                HStack {
                    Image("SubImage1")
                        .resizable()
                        .frame(width: 100, height: 110)
                    VStack(alignment: .leading) {
                        Text("Неограниченное количество цитат:")
                            .font(.custom("MontserratAlternates-Regular", size: 16))
                            .bold()
                        Text("читайте и делитесь вдохновляющими цитатами без ограничений.")
                            .font(.custom("MontserratAlternates-Regular", size: 14))
                    }
                    Spacer()
                }
                HStack {
                    Image("SubImage2")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Неограниченное количество мечт:")
                            .font(.custom("MontserratAlternates-Regular", size: 16))
                            .bold()
                        Text("ставьте новые цели и визуализируйте их без ограничений.")
                            .font(.custom("MontserratAlternates-Regular", size: 14))
                    }
                    Spacer()
                }
                HStack {
                    Image("SubImage3")
                        .resizable()
                        .frame(width: 100, height: 80)
                    VStack(alignment: .leading) {
                        Text("Неограниченное количество автоисторий:")
                            .font(.custom("MontserratAlternates-Regular", size: 16))
                            .bold()
                        Text("создавайте и делитесь своими историями о путешествиях на автомобиле.")
                            .font(.custom("MontserratAlternates-Regular", size: 14))
                    }
                    Spacer()
                }
            }
            .padding(.leading)
            Button("Отключить подписку") {
                userManager.deactivateSubscription()
            }
            .padding()
            .background(Color.red)
            .cornerRadius(8)
            .foregroundColor(.white)
            Button(action: {
                Task {
                    await userManager.purchaseSubscription()
                }
            }) {
                Rectangle()
                      .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                      .frame(height: 60)
                      .cornerRadius(100)
                      .overlay(
                          Text("Оформить")
                              .foregroundColor(.white)
                              .font(.custom("MontserratAlternates-Regular", size: 28))
                              .bold()
                      )
            }
            .padding(.top, 10)
            
            .alert("Подписка активирована!", isPresented: $showConfirmation) {
                Button("ОК", role: .cancel) {}
            }
            
            .alert("Оплата не найдена", isPresented: $showFailureAlert) {
                Button("Повторить", role: .cancel) {}
            }
            
            // Пример: отображение текущего статуса подписки
            Text(userManager.isSubscriptionEnabled ? "Подписка активна" : "Подписка неактивна")
                .foregroundColor(.gray)
                .padding(.top)
            Text("7 дней бесплатно, далее 249 руб в месяц")
                .foregroundColor(Color("InactiveColor2"))
                .font(.custom("MontserratAlternates-Regular", size: 14))
            
        }
        .padding(.horizontal, 33)
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
            .mask(self)
    }
}

#Preview {
    SubscriptionView()
}
