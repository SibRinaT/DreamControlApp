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
                    Image("IconHome")
                    Text("Tab 1")
                }
            
        DreamView()
                .tabItem {
                    Image("DreamsIcon")
                    Text("Мечтания")
                }
            
            Text("Tab 3")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Tab 3")
                }
        }
    }
}

#Preview {
    TabBar()
}
