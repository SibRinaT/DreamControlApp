//
//  TabBar.swift
//  DreamControlApp
//
//  Created by Ainur on 21.04.2024.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
                .tabItem {
                    VStack {
                        Image(selectedTab == 0 ? "ActiveHomeIcon" : "IconHome")
                        Text("Главная")
                            .foregroundColor(Color("TextColor"))
                    }
                }
                .tag(0)

            DreamView()
                .tabItem {
                    VStack {
                        Image(selectedTab == 1 ? "ActiveDreamsIcon" : "DreamsIcon")
                        Text("Мечта")
                            .foregroundColor(Color("TextColor"))
                    }
                }
                .tag(1)

            IdeasView()
                .tabItem {
                    VStack {
                        Image(selectedTab == 2 ? "ActiveIdeasIcon" : "IdeasIcon")
                        Text("Идеи")
                            .foregroundColor(Color("TextColor"))
                    }
                }
                .tag(2)
        }
    }
}

#Preview {
    TabBar()
        .environment(StoriesService())
        .environmentObject(IdeasViewModel())
}
