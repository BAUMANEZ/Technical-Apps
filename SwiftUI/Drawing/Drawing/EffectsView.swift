//
//  EffectsView.swift
//  Drawing
//
//  Created by Арсений Токарев on 24.09.2020.
//

import SwiftUI

struct EffectsView: View {
	@State private var amount: CGFloat = 0
    var body: some View {
		NavigationView {
			ScrollView {
				VStack(spacing: 50) {
					ZStack {
						Image("Image")
						
						Color.red
							.blendMode(.difference)
					}
					.clipped()
					
					Divider()
						.padding()
					
					VStack(alignment: .leading) {
						Text("Shortcut")
						Image("Image")
							.colorMultiply(.yellow)
					}
					.padding()
					
					Divider()
						.padding()
					
					VStack {
						Image("Image")
							.resizable()
							.scaledToFit()
							.saturation(Double(amount))
							.blur(radius: (1 - amount) * 10)
						
						Slider(value: $amount, in: 0 ... 1)
							.padding(.horizontal, 50)
					}
						
					
				}
			}
			.navigationBarTitle("Effects")
		}
    }
}

struct EffectsView_Previews: PreviewProvider {
    static var previews: some View {
        EffectsView()
    }
}
