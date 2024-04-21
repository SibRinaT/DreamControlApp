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
                    Text("Tab 1")
                        .tabItem {
                            Image(systemName: "1.square.fill")
                            Text("Tab 1")
                        }
                    
                    Text("Tab 2")
                        .tabItem {
                            Image(systemName: "2.square.fill")
                            Text("Tab 2")
                        }
                }
//                .shadow(radius: 10)
                .background(Color.black)
                .cornerRadius(30)
                .padding()
        
    }
}

#Preview {
    TabBar()
}
