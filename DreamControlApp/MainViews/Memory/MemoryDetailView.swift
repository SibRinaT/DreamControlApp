//
//  MemoryDetailView.swift
//  DreamControlApp
//
//  Created by Ainur on 08.05.2025.
//

import SwiftUI

struct MemoryDetailView: View {
    @State var title = "Воспоминание"

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 100)
                .overlay(
                    HStack {
                        Image("CloudForDream")
                        VStack {
                            Text("Воспоминание")
                                .foregroundColor(Color("InactiveColor2"))
                                .bold()
                                .font(.headline)
                            
                            Text(title)
                                .foregroundColor(.white)
                                .bold()
                                .font(.title)
                        }
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    }
                )
        }
    }
}

#Preview {
    MemoryDetailView()
}
