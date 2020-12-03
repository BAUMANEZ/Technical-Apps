//
//  ContentView.swift
//  Drawing
//
//  Created by Арсений Токарев on 23.09.2020.
//

import SwiftUI


struct ContentView: View {
	
    var body: some View {
		NavigationView {
			List {
				NavigationLink("Custom shape", destination: CustomShapeView())
				
				NavigationLink("Flower", destination: FlowerView())
				
				NavigationLink("Image Paint", destination: ImagePaintView())
				
				NavigationLink("Rainbow", destination: RainbowView())
				
				NavigationLink("Effects", destination: EffectsView())
				
				NavigationLink("Trapezoid", destination: AnimatedTrapezoid())
				
				NavigationLink("Challenge", destination: Challlenge())
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
