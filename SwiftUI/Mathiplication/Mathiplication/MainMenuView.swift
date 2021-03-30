//
//  MainMenuView.swift
//  Mathiplication
//
//  Created by Арсений Токарев on 30.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI


enum NumberOfQuestions: Int {
	case five = 5
	case ten = 10
	case twenty = 30
	case all
	
	var color: Color {
		switch self {
		case .five:
			return .green
		case .ten :
			return Color(red: 0.64, green: 0.89, blue: 0.23)
		case .twenty :
			return Color(.systemOrange)
		default :
			return .red
		}
	}
	
	mutating func nextCase() {
		switch self {
		case .five :
			self = .ten
			
		case .ten :
			self = .twenty
			
		case .twenty :
			self = .all
			
		case .all :
			self = .five
		}
	}
}



struct MainMenuView: View {
	@EnvironmentObject var game: GameData
	
	@State private var maxMultiplicationTable = 1
	@State private var numberOfQuestions: NumberOfQuestions = .five
	@State private var questionMarkButtonScale: CGFloat = 1

	
    var body: some View {
		Group {
			ZStack {
				BackgroundImageView(color: Color.yellow)
				VStack(spacing: 100) {
					Text("Mathiplication")
						.padding()
						.font(Font.system(size: 35, weight: .heavy, design: .monospaced))
						.background(Color.orange)
						.clipShape(RoundedRectangle(cornerRadius: 15))
						.overlay(
							RoundedRectangle(cornerRadius: 15).stroke(Color.pink, lineWidth: 3)
						)
					VStack(spacing: 30) {
						Button("Start Game") {
							self.analizeInputData()
							withAnimation(Animation.spring().delay(0.15)) {
								self.game.gameIsStarted.toggle()
							}
						}
						.cartoonStyle()
						Button(action: {
							self.numberOfQuestions.nextCase()
						}) {
							HStack(spacing: 5) {
								Text("Game Mode:")
								Text(numberOfQuestions != NumberOfQuestions.all ? "\( numberOfQuestions.rawValue) questions" : "All questions")
									.padding(.top, 3)
									.padding(.bottom, 3)
									.padding(3)
									.background(numberOfQuestions.color)
									.clipShape(RoundedRectangle(cornerRadius: 5))
							}
						}
						.cartoonStyle()
						
						VStack(spacing: 5) {
							Text("Multuplication tables")
							Stepper(maxMultiplicationTable == 1 ? "Up to \(maxMultiplicationTable) table" : "Up to \(maxMultiplicationTable) tables", value: $maxMultiplicationTable, in: 1 ... 12)
						}
						.cartoonStyle()
						
						HStack {
							Button(action: {
								withAnimation(.easeInOut(duration: 1.3)) {
									self.game.infoIsShown.toggle()
								}
							}) {
								Text("?")
									.font(.system(size: 30, weight: .bold, design: .monospaced))
									.foregroundColor(.white)
									.frame(width: 50, height: 40)
									.background(Color(.systemTeal))
									.clipShape(RoundedRectangle(cornerRadius: 10))
									.overlay(
										RoundedRectangle(cornerRadius: 10)
											.stroke(Color(.systemTeal),lineWidth: 1.75)
											.scaleEffect(self.questionMarkButtonScale)
											.opacity(Double(1.6 - self.questionMarkButtonScale))
											.animation(Animation.easeInOut(duration: 1.45).repeatForever(autoreverses: false))
											
									
									)
							} //Button(questionmark)
							.onAppear {
								self.questionMarkButtonScale = 1.6
							}
						} //HStack of additional buttons
						
					} //VStack for spacing the distance between buttons
					
				} //VStack For spacing the distance between Title and Buttons
		
			} //ZStack
			
		} //Group
		
    }
	
	func isUnique(question: Question) -> Bool {
		return !game.arrayOfQuestions.contains(question)
	}
	
	
	func generateQuestions() {
		game.arrayOfQuestions.reserveCapacity(numberOfQuestions.rawValue)
		
		// if we have up to 1 multiplication table and 20 questions, we cannot make each of them unique, because 1 mult table fits only 12 unique values.
		//But my purpose is to do my best to make questions unique
		
		if maxMultiplicationTable != 1 && numberOfQuestions != .twenty{
			for _ in 1 ... numberOfQuestions.rawValue  {
				var randomQuestion = Question(firstMultiplier: Int.random(in: 1 ... maxMultiplicationTable), secondMultiplier: Int.random(in: 1 ... 12))
				
				while !isUnique(question: randomQuestion) {
					randomQuestion.firstMultiplier = Int.random(in: 1 ... maxMultiplicationTable)
					randomQuestion.secondMultiplier = Int.random(in: 1 ... 12)
				}
				
				game.arrayOfQuestions.append(randomQuestion)
			}
			
		} else {
			for _ in 1 ... numberOfQuestions.rawValue {
				let firstMultiplier = Int.random(in: 1 ... maxMultiplicationTable)
				let secondMultiplier = Int.random(in: 1 ... 12)
				
				let randomQuestion = Question(firstMultiplier: firstMultiplier, secondMultiplier: secondMultiplier)
				game.arrayOfQuestions.append(randomQuestion)
			}
		}
	}
	
	
	func analizeInputData() {
		switch numberOfQuestions {
			
		case .all :
			game.arrayOfQuestions.reserveCapacity(maxMultiplicationTable * 12)
			for i in 1 ... maxMultiplicationTable {
				for j in 1 ... 12 {
					game.arrayOfQuestions.append(Question(firstMultiplier: i, secondMultiplier: j))
				}
			}
					
		default :
			generateQuestions()
			
		}
	}
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
		MainMenuView().environmentObject(GameData())
    }
}
