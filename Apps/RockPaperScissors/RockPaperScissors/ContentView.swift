//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Арсений Токарев on 10.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    let name: String
    
    var body: some View {
            Text(name)
                .font(.system(size: 60))
                .frame(width: 60, height: 60)
                .padding()
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 15))
    }
} // modifies buttons with emojies inside

struct TitleView: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(Color(.white))
            .padding(5)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
    }
    
} //

extension View {
    func computerTitle() -> some View {
        self.modifier(TitleView())
    }
}

struct ComputerCommentView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.tertiarySystemGroupedBackground))
            .padding(5)
            .background(Color(.purple))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
} //modifies titles like scores, moves and so on

extension View {
    func showComputerComment() -> some View {
        self.modifier(ComputerCommentView())
    }
}

enum RockPaperScissors {
    case Rock, Paper, Scissors
}

struct ContentView: View {
    
    @State private var randomChoice = Int.random(in: 0 ..< 3) // computer picks rock, paper or scissors
    @State private var shouldWin = Bool.random()
    @State private var systemMessage = ""
    @State private var shouldScorePoint: Bool? = nil
    @State private var currentScore = 0
    @State private var currentMove = 10
    @State private var showResults = false
    
    let choices = ["✊", "✋", "✌️"]
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(.systemTeal), .white]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 150) {
                VStack(spacing: 5) {
                    Text("🤖 Robby shows you: \(choices[randomChoice])")
                        .computerTitle()
                    Text("And he wants you to \(shouldWin ? "WIN" : "LOSE")")
                    .computerTitle()
                }
                VStack(spacing: 60) {
                    if self.shouldScorePoint != nil {
                        Text("\(shouldScorePoint! ? "✅" : "❌")")
                            .font(.system(size: 45))
                    }
                    else {
                        Text(" ")
                            .font(.system(size: 45))
                    }
                    HStack(spacing: 30) {
                        ForEach(0..<3) { number in
                            Button(action: {
                                //describe action here
                                self.buttonTapped(number)
                            }) {
                                ButtonView(name: self.choices[number])
                            }
                        }
                    }
                    .shadow(color: Color.black, radius: 2)
                }
                Spacer()
                HStack {
                    Text("Current score: \(currentScore)")
                        .font(.system(size: 23))
                        .showComputerComment()
                    
                    Text("Rounds left: \(currentMove)")
                        .font(.system(size: 23))
                        .showComputerComment()
                        
                }
            }
        }
        .alert(isPresented: $showResults) {
            Alert(title: Text("Game Over"), message: Text("Your final score is \(currentScore)"), dismissButton: .default(Text("Try again")) {
                self.currentMove = 10
                self.currentScore = 0
                self.shouldScorePoint = nil
                })
        }
    }
    func continueGame() {
            self.randomChoice = .random(in: 0 ..< 3)
            self.shouldWin = .random()
    }
    
    func doesWin(with number: Int) -> Bool {
        let result = number - randomChoice
        return result == 1 || result == -2 ? true : false
    }
    
    func buttonTapped(_ number: Int) {
        let youWin = doesWin(with: number)
        
        if shouldWin {
            if youWin {
                currentScore += 1
                shouldScorePoint = true
            } //youWin
            else {
                currentScore -= 1
                shouldScorePoint = false
            }
        } //shouldWin
        else {
            if !youWin {
                currentScore += 1
                shouldScorePoint = true
            } //youwin
            else {
                currentScore -= 1
                shouldScorePoint = false
            }
        } //you !shouldWin
        
        switch currentMove {
            case 1:
                showResults = true
                fallthrough
            
            default : currentMove -= 1
        }
        self.continueGame()
    }
      
   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
