//
//  ContentView.swift
//  Bullseye
//
//  Created by thit on 8/31/24.
//

import SwiftUI

struct ContentView: View {
    // Properties
    // ==========
    // Colors
    let midnightBlue = Color(red: 0, green: 0.2, blue: 0.4)
    
    // Game stats
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target: Int = Int.random(in: 1...100)
    @State var score = 0
    
    var sliderValueRounded: Int {
      Int(sliderValue.rounded())
    }
    
    @State var round = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .navigationBarTitle("🎯 Bullseye 🎯")
                HStack {
                    Text("Put the bullseye as close as you can to:")
                        .modifier(LabelStyle())
                    Text("\(target)")
                        .modifier(ValueStyle())
                }
                Spacer()
                HStack {
                    Text("1")
                        .modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                        .accentColor(Color.green)
                        .animation(.easeOut)
                    Text("100")
                        .modifier(LabelStyle())
                }
                Spacer()
                Button(action: {
                  alertIsVisible = true
                }) {
                  Text("Hit me!")
                        .modifier(ButtonLargeTextStyle())
                }
                .background(Image("Button")
                    .modifier(Shadow())
                )
                .alert(isPresented: $alertIsVisible, content: {
                    Alert(title: Text(alertTitle()),
                          message: Text(scoringMessage()),
                          dismissButton: .default(Text("Awesome!")){
                        startNewRound()
                    }
                    )
                }
                      )
                Spacer()
                HStack {
                    Button(action: {startNewGame()}) {
                        HStack {
                            Image("StartOverIcon")
                            Text("Start over")
                                .modifier(ButtonSmallTextStyle())
                        }
                    }.background(Image("Button"))
                        .modifier(Shadow())
                    
                    Spacer()
                    Text("Score:")
                        .modifier(LabelStyle())
                    Text("\(score)")
                        .modifier(ValueStyle())
                    Spacer()
                     Text("Round:")
                        .modifier(LabelStyle())
                    Text("\(round)")
                        .modifier(ValueStyle())
                    
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image("InfoIcon")
                            Text("Info")
                                .modifier(ButtonSmallTextStyle())
                        }
                    }.background(Image("Button"))
                        .modifier(Shadow())
                }
                .padding(.all, 20)
                .accentColor(midnightBlue)
            }
            .padding(.all, 20)
            .onAppear(){
                self.startNewGame()
            }
            .background(Image("Background"))
        }
        .navigationViewStyle(.stack)
    }
    
    func scoringMessage() -> String {
        return "The current slider value is \(sliderValueRounded)\n" +
        "The target value is \(target).\n" +
        "You scored \(pointsForCurrentRound()) points this round."
    }
    
    func pointsForCurrentRound() -> Int {
       let maximumScore: Int = 100
          let difference = sliderTargetDifference
          let points: Int
          if difference == 0 {
            points = 200
          } else if difference == 1 {
            points = 150
          } else {
            points = maximumScore - difference
          }
          return points
    }
    
    func alertTitle() -> String {
      let difference: Int = sliderTargetDifference
      let title: String
      if difference == 0 {
        title = "Perfect!"
      } else if difference < 5 {
        title = "You almost had it!"
      } else if difference <= 10 {
        title = "Not bad."
      } else {
        title = "Are you even trying?"
      }
      return title
    }
    
    var sliderTargetDifference: Int {
      abs(sliderValueRounded - target)
    }
    
    func startNewGame() {
        score = 0
        round = 1
        resetSliderAndTarget()
      }
    
    func startNewRound() {
        score = score + pointsForCurrentRound()
        round += 1
        resetSliderAndTarget()
    }
    
    func resetSliderAndTarget() {
        target = Int.random(in: 1...100)
        sliderValue = Double.random(in: 1...100)
    }
}

// View modifiers
// ==============
struct LabelStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.custom("Arial Rounded MT Bold", size: 18))
      .foregroundColor(Color.white)
      .modifier(Shadow())
} }

struct ValueStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.custom("Arial Rounded MT Bold", size: 24))
      .foregroundColor(Color.yellow)
      .modifier(Shadow())
} }

struct Shadow: ViewModifier {
  func body(content: Content) -> some View {
    content
      .shadow(color: Color.black, radius: 5, x: 2, y: 2)
} }

struct ButtonLargeTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.custom("Arial Rounded MT Bold", size: 18))
      .foregroundColor(Color.black)
} }

struct ButtonSmallTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.custom("Arial Rounded MT Bold", size: 12))
      .foregroundColor(Color.black)
} }

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
