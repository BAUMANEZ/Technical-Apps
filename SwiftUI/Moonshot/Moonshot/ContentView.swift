//
//  ContentView.swift
//  Moonshot
//
//  Created by Арсений Токарев on 17.09.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

class AstronautsAndMissions: ObservableObject {
	@Published var astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
	@Published var missions: [Mission] = Bundle.main.decode("missions.json")
}

struct ContentView: View {
	@ObservedObject var astronautsAndMissions = AstronautsAndMissions()
	@State var showDates = true
	
    var body: some View {
		NavigationView {
			List(astronautsAndMissions.missions) { mission in
				NavigationLink(
					destination: MissionView(mission: mission)) {
					Image(mission.image)
						.resizable()
						.scaledToFit()
						.frame(width: 70, height: 70)
					
					VStack(alignment: .leading) {
						Text(mission.displayName)
							.font(.system(size: 25, weight: .bold))
						Text(self.dateOrCrewString(mission: mission))
							.font(.system(size: 15, weight: .light))
					}
				}
				
			}
			.navigationBarTitle("Moonshot")
			.navigationBarItems(leading:
				Button(showDates ? "Show Crew" : "Show Dates") {
					self.showDates.toggle()
				}
			)
		}
	}
	func dateOrCrewString(mission: Mission) -> String {
		if showDates {
			return mission.formattedLaunchDate
		}
		
		var crewMembers = ""
		for member in mission.crew {
			if let astronaut = astronautsAndMissions.astronauts.first(where: {$0.id == member.name}) {
				crewMembers += "\(astronaut.name)\n"
			}
		}
		return crewMembers
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
