//
//  HabbitBriefView.swift
//  Habits
//
//  Created by Арсений Токарев on 27.09.2020.
//

import SwiftUI


struct ClippedOnTheLeftRectangle: Shape {
	let radius: CGFloat
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
		path.addRelativeArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: .radians(.pi / 2), delta: .radians(.pi / 2))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
		path.addRelativeArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius), radius: radius, startAngle: .radians(.pi), delta: .radians(.pi / 2))
	
		
		return path
	}
}


struct HabitBriefView: View {
	let title: String
	let imageName: String
	let colorTheme: ColorTheme
    var body: some View {
		GeometryReader { geo in
			HStack {
				Text(title)
					.lineLimit(1)
					.multilineTextAlignment(.leading)
					.font(.system(size: 30, weight: .bold))
					.allowsTightening(true)
					.foregroundColor(colorTheme.foregroundColor)
					.shadow(color: Color(.systemGray).opacity(0.15), radius: 5, x: -10, y: 10)
					.minimumScaleFactor(0.005)
					.padding()
					
				Spacer()
				
				Image(imageName)
					.resizable()
					.scaledToFit()
					.padding()
					.background(Color(.systemGray6))
					.mask(ClippedOnTheLeftRectangle(radius: 15))
					.opacity(0.95)
					.shadow(radius: 1, x: -5, y: 1)
				
			}
			.frame(height: 125)
			.background(colorTheme.backgroundColor)
			.cornerRadius(10)
		}
		
		
    }
}

struct HabitBriefView_Previews: PreviewProvider {
    static var previews: some View {
		HabitBriefView(title: "Drawing sketches", imageName: "reading6", colorTheme: ColorTheme(backgroundColorHex: "#ffff33", foregroundColorHex: "#000000"))
    }
}
