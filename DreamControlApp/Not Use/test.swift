//
//  test.swift
//  DreamControlApp
//
//  Created by Ainur on 04.12.2024.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                // Вывод всех шрифтов в консоль при появлении вью
                for family in UIFont.familyNames {
                    print(family)
                    for font in UIFont.fontNames(forFamilyName: family) {
                        print("  \(font)")
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}
