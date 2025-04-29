//
//  SubscriptionView.swift
//  DreamControlApp
//
//  Created by Ainur on 17.06.2024.
//

import SwiftUI

struct SubscriptionView: View {
    var body: some View {
        VStack {
            Text("Подписка")
                .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                .font(.system(size: 63))
                .bold()
            VStack(alignment: .leading)  {
                HStack {
                    Image("SubImage1")
                        .resizable()
                        .frame(width: 100, height: 110)
                    VStack(alignment: .leading) {
                        Text("Неограниченное количество цитат:")
                            .bold()
                        Text("читайте и делитесь вдохновляющими цитатами без ограничений.")
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
                            .bold()
                        Text("ставьте новые цели и визуализируйте их без ограничений.")
                    }
                    Spacer()
                }
                HStack {
                    Image("SubImage3")
                        .resizable()
                        .frame(width: 100, height: 80)
                    VStack(alignment: .leading) {
                        Text("Неограниченное количество автоисторий:")
                            .bold()
                        Text("создавайте и делитесь своими историями о путешествиях на автомобиле.")
                    }
                    Spacer()
                }
            }
            .padding(.leading)
            Button(action: {}) {
                Rectangle()
                    .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                    .frame(height: 60)
                    .cornerRadius(100)
                    .overlay(
                        Text("Попробовать")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .bold()
                    )
            }
            
            Text("7 дней бесплатно, далее 299 руб в месяц")
                .foregroundColor(Color("InactiveColor2"))
                .font(.system(size: 16))

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
