//
//  TabBar.swift
//  DreamControlApp
//
//  Created by Ainur on 21.04.2024.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            // Вставьте ваши вкладки здесь
            MainView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Tab 1")
                }
            
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Tab 2")
                }
            
            Text("Tab 3")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Tab 3")
                }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
               .background(
                   GeometryReader { geometry in
                       RoundedRectangle(cornerRadius: 25.0)
                           .foregroundColor(Color.white)
                           .shadow(radius: 10)
                           .padding(.horizontal)
                           .frame(width: geometry.size.width, height: 80) // Высота таб бара
                           .offset(y: 720) // Смещение вверх, чтобы таб бар был снизу
                   }
                   )
    }
}

#Preview {
    TabBar()
}
