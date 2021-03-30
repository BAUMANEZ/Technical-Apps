//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Арсений Токарев on 04.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI


struct FlagImage: View {
    var name: String
    
    var body: some View {
            Image(name)
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                .shadow(color: Color.black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var wrongAnswer = 0
    @State private var showingScore = false
 //   @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var highestScore = 0
    @State private var rotationAmount = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(Color.white)
                        .fontWeight(.medium)
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(Color.white)
                        .fontWeight(.black)
                        .font(.largeTitle)
                    
                }
                ForEach(0 ..< 4) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(number == self.correctAnswer ? self.rotationAmount : 0), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.showingScore && number != self.correctAnswer ? 0.25 : 1.0)
            
                }
                Spacer()
                VStack(spacing: 3) {
                    HStack(spacing: 100) {
                        Text("Current score:")
                            .foregroundColor(Color.secondary)
                            .font(.body)
                            .fontWeight(.heavy)
                        Text("Highest score:")
                            .foregroundColor(Color.secondary)
                            .font(.body)
                            .fontWeight(.heavy)
                    }
                    HStack(alignment: .center, spacing: 210) {
                        Text("\(userScore)")
                            .foregroundColor(Color.secondary)
                            .font(.title)
                            .fontWeight(.heavy)
                            
                        Text("\(highestScore)")
                            .foregroundColor(Color.secondary)
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                }
                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text("Wrong!"), message: Text("That's a flag of \(countries[wrongAnswer])"), dismissButton: .default(Text("Start new game")) {
                    self.continueGame()
                    })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            withAnimation(.easeInOut(duration: 0.65)) {
                self.rotationAmount += 360
            }
            
            userScore += 1
            if userScore > highestScore {
                highestScore = userScore
            }
            self.continueGame()
        }
        else {
           
            wrongAnswer = number
            userScore = 0
            showingScore = true
        }

    }
    
    func continueGame() {
        countries.shuffle()
        correctAnswer = .random(in: 0 ..< 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
