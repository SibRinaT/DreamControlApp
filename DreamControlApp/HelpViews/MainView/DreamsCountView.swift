//
//  DreamsCountView.swift
//  DreamControlApp
//
//  Created by Ainur on 19.06.2024.
//

import SwiftUI

@MainActor
struct DreamsCountView: View {
    @Environment(StoriesService.self) private var storiesService
    @Environment(IdeasViewModel.self) private var ideasViewModel

    var body: some View {
        HStack {
            ZStack {
//                Color.red
//                color for testing background
                Rectangle()
                    .frame(height: 60)
                    .foregroundColor(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .overlay(
                        VStack {
                            Text("\(storiesService.dreams.count)")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.white)
                            Text("Мечты")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                            .padding(.vertical)
                    )
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    .padding(.vertical, 20)
                    .padding(.horizontal)
                Image("CloudSmallImage")
                    .offset(CGSize(width: 57, height: 15))
                Image("CloudImage")
                    .offset(CGSize(width: 75, height: -25))
                Image("CloudSmallImage")
                    .offset(CGSize(width: -57, height: -15))
                Image("CloudImage")
                    .offset(CGSize(width: -75, height: 20))
            }
            .frame(height: 100)
            ZStack {
//                Color.blue
//                color for testing background
                Rectangle()
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    .frame(height: 60)
                    .foregroundColor(Color("SuccessColor"))
                    .cornerRadius(10)
                    .overlay(
                        VStack {
                            Text("\(ideasViewModel.favoriteIdeas.count)")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.white)
                            Text("Идей")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                            .padding(.vertical)
                    )
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    .padding(.horizontal)
                Image("StarSmallImage")
                    .offset(CGSize(width: -50, height: 18))
                Image("StarImage")
                    .offset(CGSize(width: -75, height: -25))
                Image("StarSmallImage")
                    .offset(CGSize(width: 57, height: -10))
                Image("StarImage")
                    .offset(CGSize(width: 75, height: 25))
            }
            .frame(height: 100)

        }
    }
}

#Preview {
    DreamsCountView()
        .environment(StoriesService())
        .environmentObject(IdeasViewModel()) 
}
