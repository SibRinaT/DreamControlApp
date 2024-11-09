//
//  TestPageView.swift
//  DreamControlApp
//
//  Created by Ainur on 01.04.2024.
//

import SwiftUI

struct TestPageView: View {
    @State private var currentIndex = 0
    private let colors: [Color] = [.red, .blue, .green, .yellow]
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<colors.count, id: \.self) { index in
                colors[index]
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))    }
}

#Preview {
    TestPageView()
}
