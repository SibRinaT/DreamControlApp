//
//  OrView.swift
//  DreamControlApp
//
//  Created by Ainur on 02.04.2024.
//

import SwiftUI

struct OrView: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 133, height: 1)
                .foregroundColor(Color("PrimaryColor"))
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)

            Text("OR")
                .foregroundColor(Color("PrimaryColor"))
                .bold()
            
            Rectangle()
                .frame(width: 133, height: 1)
                .foregroundColor(Color("PrimaryColor"))
        }
    }
}

#Preview {
    OrView()
}
