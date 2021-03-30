//
//  AnimatedTrapezoid.swift
//  Drawing
//
//  Created by Арсений Токарев on 24.09.2020.
//

import SwiftUI

struct Trapezoid: Shape {
	var insetAmount: CGFloat
	
	//we use this computed property to animate the changes
	///if there are more values to animate we should use animatablePair
	var animatableData: CGFloat {
		get { insetAmount }
		set { self.insetAmount = newValue}
	}
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: 0, y: rect.maxY))
		path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: 0, y: rect.maxY))
		return path
	}
	
}


struct AnimatedTrapezoid: View {
	@State private var amount: CGFloat = 70
    var body: some View {
		VStack {
			ZStack {
				Trapezoid(insetAmount: amount)
					.fill(Color.blue)
					.frame(width: 300, height: 400)
					.onTapGesture {
						withAnimation(.spring()) {
							self.amount = CGFloat.random(in: 5 ... 130)
						}
					}
				Text("Tap Me")
					.font(.largeTitle)
			}
		}
    }
}

struct AnimatedTrapezoid_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTrapezoid()
    }
}
