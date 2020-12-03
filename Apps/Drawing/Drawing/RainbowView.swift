//
//  RainbowView.swift
//  Drawing
//
//  Created by Арсений Токарев on 24.09.2020.
//

import SwiftUI

struct ColorCyclingCircle: View {
	let amount: Double
	let steps: Int
	var body: some View {
		ZStack {
			ForEach(0 ..< steps) { value in
				Circle()
					.inset(by: CGFloat(value))
					.strokeBorder(LinearGradient(gradient: Gradient(colors: [
						color(for: value, brightness: 1),
						color(for: value, brightness: 0.5)
					]), startPoint: .top, endPoint: .bottom)
					)
			}
		}
		.drawingGroup()
	}
	
	func color(for value: Int, brightness: Double) -> Color {
		var targetHue = Double(value) / Double(steps) + amount
		
		if targetHue > 1 {
			targetHue -= 1
		}
		
		return Color(hue: targetHue, saturation: 1, brightness: brightness)
		
		
	}
}

struct RainbowView: View {
	@State private var amount = 0.0
	@State private var steps = 100
    var body: some View {
		VStack {
			ColorCyclingCircle(amount: amount, steps: steps)
				.padding()
			
			Slider(value: $amount, in: 0 ... 1)
				.padding()
			
			Stepper("\(self.steps) steps", value: $steps, in: 50 ... 200, step: 10)
				.padding()
		}
    }
}

struct RainbowView_Previews: PreviewProvider {
    static var previews: some View {
        RainbowView()
    }
}
