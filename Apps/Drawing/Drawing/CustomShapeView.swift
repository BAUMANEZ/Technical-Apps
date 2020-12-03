//
//  CustomShapeView.swift
//  Drawing
//
//  Created by Арсений Токарев on 24.09.2020.
//

import SwiftUI

struct SomeShape: Shape {
	let cornerLength: CGFloat
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.midX - rect.width / cornerLength, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.midY - rect.height / cornerLength))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.midY + rect.height / cornerLength))
		path.addLine(to: CGPoint(x: rect.midX - rect.width / cornerLength, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.midX + rect.width / cornerLength, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY + rect.height / cornerLength))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY - rect.height / cornerLength))
		path.addLine(to: CGPoint(x: rect.midX + rect.width / cornerLength, y: rect.minY))
		
		
		return path
	}
}


struct CustomShapeView: View {
    var body: some View {
		SomeShape(cornerLength: 10)
			.frame(width: 300, height: 300)
    }
}

struct CustomShapeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapeView()
    }
}
