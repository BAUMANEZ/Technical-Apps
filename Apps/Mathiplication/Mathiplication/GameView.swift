//
//  GameView.swift
//  Mathiplication
//
//  Created by Арсений Токарев on 27.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

enum InputButtons {
	case one, two, three, four, five, six, seven, eight, nine, zero
	case erase, apply
	
	var color: Color {
		switch self {
		case .erase :
			return .red
		case .apply :
			return .green
		default :
			return Color(.systemTeal)
		}
	}
	
	
	
	var text: String {
		switch self {
		case .one :
			return "1"
			
		case .two :
			return "2"
			
		case .three :
			return "3"
			
		case .four :
			return "4"
			
		case .five :
			return "5"
			
		case .six :
			return "6"
			
		case .seven :
			return "7"
			
		case .eight :
			return "8"
			
		case .nine :
			return "9"
			
		case .zero :
			return "0"
			
		case .erase :
			return "⌫"
		case .apply :
			return "✔︎"
		}
	}
	
}

struct GameView: View {
	@EnvironmentObject var game: GameData
	@State private var answerText: String = ""
	@State private var currentQuestion = Int.random(in: 0 ..< 5)
	@State private var showAlert = false
	let buttons: [[InputButtons]] = [
		[.one, .two, .three],
		[.four, .five, .six],
		[.seven, .eight, .nine],
		[.erase, .zero, .apply]
	]
    var body: some View {
		
		
		return ZStack {
			BackgroundImageView(color: Color(.systemIndigo))
				VStack {
					HStack {
						Spacer()
						Button("Return") {
							withAnimation(Animation.spring().delay(0.15)) {
								self.game.gameIsStarted.toggle()
							}
						}
						.cartoonStyle(frameWidth: 50, frameHeight: 10, fontSize: 15, fontWeight: .heavy)
						
					}
					.padding()
					
					VStack(alignment: .leading) {
						Text("What is the multiplication of \(game.arrayOfQuestions[currentQuestion].firstMultiplier) and \(game.arrayOfQuestions[currentQuestion].secondMultiplier)?")
							.padding()
						HStack {
							Text("Your answer:")
								
							Text("\(answerText)")
						}
						.padding(.leading)
						.padding(.bottom)
				
					}
					.font(.system(size: (UIScreen.main.bounds.width - 2 * 25) / 19))
					.frame(width: (UIScreen.main.bounds.width - 2 * 25))
					.background(Color.white)
					.clipShape(RoundedRectangle(cornerRadius: 5))
					.shadow(radius: 3)
					.padding()
					.background(Color(.systemGray6))
					.clipShape(RoundedRectangle(cornerRadius: 10))
					
					VStack {
						HStack(alignment: .center, spacing: 20) {
							Text("👍: \(self.game.correctAnswers)")
								.fontWeight(.semibold)
								.playerProgressTitle(color: Color(.systemGreen))
								//add animations
								
							Text("👎: \(self.game.wrongAnswers)")
								.fontWeight(.semibold)
								.playerProgressTitle(color: Color(.systemRed))
						}
						.padding()
						
						
//						HStack {
//							Text("Your score: ")
//								.fontWeight(.semibold)
//							+ Text("\(2) ")
//								.font(.system(size: 20, weight: .heavy))
//							+ Text("points")
//								.fontWeight(.semibold)
//						}
//						.playerProgressTitle()
//
					
					}
					Spacer()
					VStack(alignment: .center, spacing: 50) {
						ForEach(buttons, id: \.self) { row in
							HStack(alignment: .center, spacing: 50) {
								ForEach(row, id: \.self) { button in
									Button(action: {
										// to avoid using self. constantly we create a reference to our GAME object
										let currentGame = self.game
										switch button {
											case .apply :
												
												// if the input field is empty we wake an alert
												if self.answerText.count == 0 {
													self.showAlert = true
												}
												
												if self.game.arrayOfQuestions.count > 1 {
													guard let playerAnswer = Int(self.answerText) else { return }
													//check if the answer is correct
													let correctAnswer = currentGame.arrayOfQuestions[self.currentQuestion].result
													if playerAnswer == correctAnswer {
														// add some more options for scores later (e.g. the faster player gives the answer the more score he gets
														currentGame.totalScore += 1
														currentGame.correctAnswers += 1
													} else {
														currentGame.wrongAnswers += 1
													}
													currentGame.arrayOfQuestions.remove(at: self.currentQuestion)
													self.currentQuestion = self.chooseQuestion(from: currentGame.arrayOfQuestions)
													self.answerText = ""
												} else {
												withAnimation(.easeInOut(duration: 1.5)) {
													currentGame.showResults = true
													currentGame.gameIsStarted = false
												}
											}
										case .erase :
											if self.answerText.count != 0 {
												self.answerText.removeLast()
											}
											
										default:
											if self.answerText.count < 3 {
												self.answerText += button.text
											}
										}
									}) {
										ContentInsideOfButton(text: button.text, color: button.color, font: .system(size: self.buttonWidth(), weight: .bold, design: button == InputButtons.erase ? .monospaced : .serif))
									}
								}
							}
						}
					}
				
				} //top VStack
				
			} //ZStack
			.alert(isPresented: $showAlert) {
				Alert(title: Text("Oh no!"), message: Text("You have not entered any number"), dismissButton: .default(Text("OK")))
			}
	}
				
				
	
	func chooseQuestion(from array: [Question]) -> Int {
		return Int.random(in: 0 ..< array.count)
	}
	
	func buttonWidth() -> CGFloat {
		return (UIScreen.main.bounds.width - 45 * 4) / 3
	}
	
}



struct ContentInsideOfButton: View {
	let text: String
	let color: Color
	let font: Font
	
	var body: some View {
		let widthAndHeight = GameView().buttonWidth()
		return	Text(text)
					.foregroundColor(color)
					.font(font)
					.frame(width: widthAndHeight, height: widthAndHeight)
					.background(Color.white)
					.cornerRadius(15)
					.shadow(radius: 5)
					.overlay(
						RoundedRectangle(cornerRadius: 15)
							.stroke(Color(.systemGray), lineWidth: 2)
					) //overlay
	}
	
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
		GameView().environmentObject(GameData())
    }
}

