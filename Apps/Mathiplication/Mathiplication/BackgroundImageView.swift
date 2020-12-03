//
//  InfoView.swift
//  Mathiplication
//
//  Created by Арсений Токарев on 25.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

extension Int {
	func isEven() -> Bool {
		return self % 2 == 0
	}
}

struct BackgroundImageView: View {
	let color: Color
	let angles: [Double] = [45, 124, 330, 84, 27, 54, 164, 88, 21, 4]
	@State private var rotationAmount = 0.0
	@State private var pulsingScale: CGFloat = 1
	
    var body: some View {
		ZStack {
			color.edgesIgnoringSafeArea(.all)
				VStack(spacing: 90) {
					// 15 is a heigh of each triangle and 80 is the spacing between them
					ForEach(1 ..< Int(UIScreen.main.bounds.height / (15 + 80))) { row in
							HStack(spacing: 40) {
								// the same idea as for the height
								ForEach(1 ..< Int(UIScreen.main.bounds.width / (15 + 40)) + 2) { col in
									Triangle()
										.fill(Color.white)
										.frame(width: 15, height: 15)
										.rotationEffect(.degrees(self.angles[Int.random(in: 0 ..< self.angles.count)] + self.rotationAmount))
										.scaleEffect(self.pulsingScale)
										.animation(Animation.easeInOut(duration: 1.75).repeatForever(autoreverses: true))
										.onAppear {
											self.rotationAmount += 3
											self.pulsingScale = 1.25
										}
								
							}
						}
					} //ForEach(row)
				} //VStack for rows
		} //ZStack
    } //body
} //View

struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
		BackgroundImageView(color: Color.yellow)
    }
}
