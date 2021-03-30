//
//  AstronautView.swift
//  Moonshot
//
//  Created by Арсений Токарев on 23.09.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
	struct Biography {
		var information: Astronaut
		let missions: [Mission]
	}
	
	let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
	let astronaut: Biography
	
    var body: some View {
		NavigationView {
			GeometryReader { geo in
				ScrollView(.vertical) {
					Image(self.astronaut.information.id)
						.resizable()
						.scaledToFill()
						.frame(width: geo.size.width)
					
					Text(self.astronaut.information.description)
						.padding()
						.font(.system(size: 22, weight: .light))
					
					
					Divider()
						.padding(.horizontal)
					
					VStack(alignment: .leading) {
						Text("\(astronaut.information.name) took part in the following missions")
							.font(.system(size: 30, weight: .heavy))
							
						ForEach(astronaut.missions) { mission in
							NavigationLink(
								destination: MissionView(mission: mission)) {
								HStack {
									Image(mission.image)
										.resizable()
										.scaledToFill()
										.frame(width: 90, height: 90)
									VStack(alignment: .leading) {
										Text(mission.displayName)
											.font(.system(size: 30, weight: .semibold))
										Text(mission.formattedLaunchDate)
											.font(.system(size: 15, weight: .medium))
										
									}
									Spacer()
								}
							}
							.buttonStyle(PlainButtonStyle())
						}
					}
					.padding(.horizontal)
						
				}
				.navigationBarTitle(Text(astronaut.information.name), displayMode: .inline)
			}
		}
    }
	
	init(astronaut: Astronaut) {
		var associatedMissions = [Mission]()
		
		for mission in AstronautsAndMissions().missions {
			if mission.crew.contains(where: {$0.name == astronaut.id}) {
				associatedMissions.append(mission)
			}
		}
		self.astronaut = Biography(information: astronaut, missions: associatedMissions)
	}
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
		AstronautView(astronaut: AstronautsAndMissions().astronauts[14])
    }
}
