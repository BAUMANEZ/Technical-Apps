//
//  DragGesture.swift
//  Habits
//
//  Created by Арсений Токарев on 29.09.2020.
//

import SwiftUI

struct DragGesture: View {
	@State private var width: CGFloat = 30
	@State private var dragAmount = CGSize.zero
    var body: some View {
		
		VStack {
			ZStack(alignment: .leading) {
				Color.gray
					.padding()
					.frame(width: UIScreen.main.bounds.width, height: 200)
					.offset(dragAmount)
				
				

				Color.red
					.padding()
					.frame(width: width, height: 200)
					.shadow(radius: 2)

			}
			//Slider(value: $width, in: 20 ... UIScreen.main.bounds.width)
				.padding(.horizontal)

		}
		
    }
}

struct DragGesture_Previews: PreviewProvider {
    static var previews: some View {
        DragGesture()
    }
}
