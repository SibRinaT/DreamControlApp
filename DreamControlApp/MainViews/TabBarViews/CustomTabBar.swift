//
//  CustomTabBarView.swift
//  DreamControlApp
//
//  Created by Ainur on 18.04.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @State private var selectedTab = 0
    
    var body: some View {
            VStack {
                Spacer()
                
                // Основное содержимое, меняющееся в зависимости от выбранной вкладки
                Group {
                    if selectedTab == 0 {
                        MainView(selectedTab: $selectedTab)
                    } else if selectedTab == 1 {
                        DreamView(selectedTab: $selectedTab)
                    } else if selectedTab == 2 {
                        IdeasView(selectedTab: $selectedTab)
                    } else if selectedTab == 3 {
                        SettingsView(selectedTab: $selectedTab)
                    }
                        else if selectedTab == 4 {
                        MemoriesView(selectedTab: $selectedTab)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Кастомный Tab Bar
                HStack {
                    TabBarButton(icon: selectedTab == 0 ? "ActiveHomeIcon" : "IconHome", label: "Главная", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    Spacer()
                    TabBarButton(icon: selectedTab == 1 ? "ActiveDreamsIcon" : "DreamsIcon", label: "Мечта", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    Spacer()
                    TabBarButton(icon: selectedTab == 2 ? "ActiveIdeasIcon" : "IdeasIcon", label: "Идеи", isSelected: selectedTab == 2) {
                        selectedTab = 2
                    }
                    Spacer()
                    TabBarButton(icon: selectedTab == 3 ? "ActiveSettingIcon" : "SettingIcon", label: "Настройки", isSelected: selectedTab == 3) {
                        selectedTab = 3
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
                .background(Color.white)
                .cornerRadius(40)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .padding(.bottom, -40)
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
    
    struct TabBarButton: View {
        let icon: String
        let label: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            VStack {
                if isSelected {
                    // Индикатор над активной иконкой
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.yellow)
                        .frame(width: 10, height: 5)
                        .offset(y: -50)
                }
                Image(icon)
                    .font(.system(size: 20))
                    .foregroundColor(isSelected ? Color.blue : Color.gray)
                    .padding(.top, -40)
                
                Text(label)
                    .font(.caption)
                    .padding(.top, -10)
                    .foregroundColor(Color("TextColor"))
            }
            .padding(.vertical, 8)
            .onTapGesture {
                action()
            }
        }
    }

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
            .environment(IdeasViewModel())
    }
}
