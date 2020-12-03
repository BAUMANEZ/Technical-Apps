//
//  ContentView.swift
//  Mathiplication
//
//  Created by Арсений Токарев on 25.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//




import SwiftUI


struct Question: Equatable {
	var firstMultiplier: Int
	var secondMultiplier: Int
	
	var result: Int {
		return firstMultiplier * secondMultiplier
	}
	
	static func ==(lhs: Question, rhs: Question) -> Bool {
		return lhs.firstMultiplier == rhs.firstMultiplier && lhs.secondMultiplier == rhs.secondMultiplier
	}
}

class GameData: ObservableObject {
	
	@Published var gameIsStarted: Bool
	@Published var infoIsShown: Bool
	@Published var showResults: Bool
	@Published var arrayOfQuestions = [Question]()
	@Published var totalScore: Int
	@Published var correctAnswers: Int
	@Published var wrongAnswers: Int
	
	
	
	init() {
		gameIsStarted = false
		infoIsShown = false
		showResults = false
		arrayOfQuestions = []
		totalScore = 0
		correctAnswers = 0
		wrongAnswers = 0
		
//		for _ in 0 ... 4 {
//			self.arrayOfQuestions.append(Question(firstMultiplier: 1, secondMultiplier: 1))
//		}
		
	}
}


struct ContentView: View {
	@EnvironmentObject var game: GameData
	
    var body: some View {
		ZStack {
			if !game.gameIsStarted && !game.infoIsShown && !game.showResults {
				MainMenuView()
					.transition(.opacity)
			}
			
			if game.gameIsStarted {
				GameView()
					.transition(.opacity)
			}
			if game.infoIsShown {
				PifagorTableView()
					.transition(.opacity)
			}
			
			if game.showResults {
				ResultsView()
					.transition(.opacity)
			}
			
			
		}
	}
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView().environmentObject(GameData())
    }
}



struct CartoonButtonDesign: ViewModifier {
	let frameWidth: CGFloat
	let frameHeight: CGFloat
	let fontSize: CGFloat
	let fontWeight: Font.Weight
	let fontDesign: Font.Design
	let backgroundColor: Color
	
	func body(content: Content) -> some View {
		content
			.foregroundColor(.white)
			.font(.system(size: fontSize, weight: .semibold, design: .rounded))
			.frame(width: frameWidth, height: frameHeight)
			.padding()
			.background(Color(.systemTeal))
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.overlay(
				RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2.5)
			)
	}
}

extension View {
	func cartoonStyle(frameWidth: CGFloat = 226, frameHeight: CGFloat = 35, fontSize: CGFloat = 18, fontWeight: Font.Weight = .semibold, fontDesign: Font.Design = .rounded, backgroundColor: Color = Color(.systemTeal)) -> some View {
		modifier(CartoonButtonDesign(frameWidth: frameWidth, frameHeight: frameHeight, fontSize: fontSize, fontWeight: fontWeight, fontDesign: fontDesign, backgroundColor: backgroundColor))
	}
}




struct scoreText: ViewModifier {
	let color: Color
	func body(content: Content) -> some View {
		content
			.frame(height: 25)
			.padding()
			.background(color)
			.clipShape(Capsule())
	}

}

extension View {
	func playerProgressTitle(color: Color) -> some View {
		self.modifier(scoreText(color: color))
	}
}
