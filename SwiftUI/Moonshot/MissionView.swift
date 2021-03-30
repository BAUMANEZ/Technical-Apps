//
//  MissionView.swift
//  Moonshot
//
//  Created by Арсений Токарев on 22.09.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct MissionView: View {
	
	struct CrewMember {
		let role: String
		let astronaut: Astronaut
	} //nested struct
	
	
	let mission: Mission
	let astronauts: [CrewMember]
	
    var body: some View {
		NavigationView {
			GeometryReader { geo in
				ScrollView(.vertical) {
					VStack(alignment: .center) {
						Image(self.mission.image)
							.resizable()
							.scaledToFit()
							.frame(maxWidth: geo.size.width * 0.7)
							.padding()
						Text("Launch Date: \(self.mission.formattedLaunchDate)")
							.font(.headline)
							.padding()
							.background(Color(.systemGray5))
							.cornerRadius(5)
							
					}
					
					Text(self.mission.description)
						.font(.system(size: 22, weight: .light))
						.padding()
					
					Divider()
						.padding(.horizontal)
					
					VStack(alignment: .leading) {
						Text("Crew")
							.font(.system(size: 45, weight: .heavy))
							.padding(.horizontal)
						
						ForEach(astronauts, id: \.role) { crewMember in
							NavigationLink(destination: AstronautView( astronaut: crewMember.astronaut)) {
								HStack(alignment: .center) {
									Image(crewMember.astronaut.id )
										.resizable()
										.scaledToFill()
										.frame(width: 90, height: 70)
										.clipShape(RoundedRectangle(cornerRadius: 25))
										.overlay(
											RoundedRectangle(cornerRadius: 25)
												.strokeBorder(Color.primary, lineWidth: 0.5)
										)
									
									VStack(alignment: .leading) {
										Text(crewMember.role)
											.font(.system(size: 25, weight: .bold))
										Text(crewMember.astronaut.name)
											.font(.system(size: 25, weight: .medium))
									}
									
									Spacer()
								}
								.padding(.horizontal)
							}
							.buttonStyle(PlainButtonStyle())
						}
					}
					
					Spacer(minLength: 25)
				}
			}
			.navigationBarTitle(Text(mission.displayName), displayMode: .inline)
		}
    }
	
	init(mission: Mission) {
		self.mission = mission
		var matches = [CrewMember]()
		for member in mission.crew {
			if let match = AstronautsAndMissions().astronauts.first(where: {$0.id == member.name}) {
				matches.append(CrewMember(role: member.role, astronaut: match))
			} else {
				fatalError("Missing \(member)")
			}
		}
		self.astronauts = matches
	}
	
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
		MissionView(mission: AstronautsAndMissions().missions[0])
    }
}
