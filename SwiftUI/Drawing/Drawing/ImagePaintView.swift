//
//  ImagePaintView.swift
//  Drawing
//
//  Created by Арсений Токарев on 24.09.2020.
//

import SwiftUI

struct ImagePaintView: View {
    var body: some View {
		Capsule()
			.strokeBorder(ImagePaint(image: Image("Image"), scale: 0.3), lineWidth: 30)
			.frame(width: 400, height: 800)
    }
}

struct ImagePaintView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaintView()
    }
}
