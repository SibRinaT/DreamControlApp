//
//  DreamView.swift
//  DreamControlApp
//
//  Created by Ainur on 16.06.2024.
//

import SwiftUI

struct DreamView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("DCIcon")
                    Text("Мечтания")
                        .font(.largeTitle)
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    Spacer()
                }
                
                ScrollView {
                    Button(action: {}, label: {
                        
                    })
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DreamView()
}
