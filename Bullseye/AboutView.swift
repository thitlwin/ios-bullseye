//
//  AboutView.swift
//  Bullseye
//
//  Created by thit on 10/23/24.
//

import SwiftUI

struct AboutView: View {
    // Constants
    let beige = Color(red: 1.0,
                      green: 0.84,
                      blue: 0.70)
    
    var body: some View {
        Group {
            VStack {
                Text("❤️ Bullseye 🩷")
                    .modifier(AboutHeadingStyle())
                    .navigationBarTitle("About Bulleye")
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                    .modifier(AboutBodyStyle())
                    .lineLimit(nil)
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
                    .modifier(AboutBodyStyle())
                    .lineLimit(nil)
                Text("Enjoy!")
                    .modifier(AboutBodyStyle())
            }.background(beige)
        }
    }
}

// View modifiers
// ==============
struct AboutHeadingStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.custom("Arial Rounded MT Bold", size: 30))
      .foregroundColor(Color.black)
      .padding(.top, 20)
      .padding(.bottom, 20)
} }
struct AboutBodyStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.custom("Arial Rounded MT Bold", size: 16))
      .foregroundColor(Color.black)
      .padding(.leading, 60)
      .padding(.trailing, 60)
      .padding(.bottom, 20)
} }

#Preview {
    AboutView()
}
