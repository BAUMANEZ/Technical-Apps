//
//  Challlenge.swift
//  Drawing
//
//  Created by Арсений Токарев on 24.09.2020.
//

import SwiftUI

struct Triangle: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		return path
	}
}

struct Arrow: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addPath(Triangle().path(in: rect))
		path.addRect(CGRect(x: rect.midX - rect.width / 6, y: rect.midY, width: rect.width / 3, height: rect.height / 2))
		return path
	}
}

struct ColorCyclingRectangle: View {
	var position: CGFloat
	let steps = 100
	var amount: Double
	
	var body: some View {
		ZStack {
			ForEach(0 ..< steps) { value in
				Rectangle()
					.inset(by: CGFloat(value) + position)
					.stroke(color(for: value, brightness: 1))
					
			}
		}
	}
	func color(for value: Int, brightness: Double) -> Color {
		var targetHue = Double(value) / Double(steps) + amount
		
		if targetHue > 1 {
			targetHue -= 1
		}
		return Color.init(hue: targetHue, saturation: 1, brightness: brightness)
	}
}

struct Challlenge: View {
	@State private var lineWidth: CGFloat = 10
	@State private var position: CGFloat = 0
    var body: some View {
		NavigationView {
			ScrollView {
				Arrow()
					.stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
					.frame(width: 300, height: 500)
				
				Slider(value: $lineWidth, in: 1 ... 15)
					.padding()
				
				Divider()
					.padding()
				
				ColorCyclingRectangle(position: position, amount: 0)
					.frame(width: 300, height: 500)
				Slider(value: $position, in: 0 ... 55)
					.padding()
			}
		}
    }
}

struct Challlenge_Previews: PreviewProvider {
    static var previews: some View {
        Challlenge()
    }
}
