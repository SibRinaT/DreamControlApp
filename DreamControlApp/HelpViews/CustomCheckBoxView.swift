//
//  CustonCheckBoxView.swift
//  DreamControlApp
//
//  Created by Ainur on 02.04.2024.
//

import SwiftUI

struct CustomCheckBoxViewStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
           Button {
               configuration.isOn.toggle()
           } label: {
               HStack {
                   if configuration.isOn {
                       Image("CheckBoxStar")
                           .foregroundColor(.yellow)
                           .frame(width: 20, height: 20)
                   } else {
                       RoundedRectangle(cornerRadius: 2)
                           .fill(configuration.isOn ? Color("PrimaryColor") : Color.clear)
                           .frame(width: 20, height: 20)
                           .overlay(
                               RoundedRectangle(cornerRadius: 2)
                                   .stroke(Color("PrimaryColor"), lineWidth: 2)
                           )
                   }
                   configuration.label
               }
               .foregroundColor(configuration.isOn ? Color.white : Color.primary)
           }
       }
   }

   struct CustomCheckBoxView: View {
       @State private var isChecked = false
       @State var text: String

       var body: some View {
           Toggle(isOn: $isChecked) {
               Text(text)
                   .foregroundColor(Color("TextColor"))
           }
           .toggleStyle(CustomCheckBoxViewStyle())
           .padding()
       }
   }

   struct ContentView_Previews: PreviewProvider {
       static var previews: some View {
           CustomCheckBoxView(text: "")
       }
   }
