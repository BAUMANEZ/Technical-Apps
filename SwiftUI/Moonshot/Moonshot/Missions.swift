//
//  Missions.swift
//  Moonshot
//
//  Created by Арсений Токарев on 20.09.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
	
	struct CrewRole: Codable {
		let name: String
		let role: String
	}
	
	let id: Int
	let launchDate: Date?
	let crew: [CrewRole]
	let description: String
	
	var displayName: String {
		return "Apollo - \(id)"
	}
	var image: String {
		return "apollo\(id)"
	}
	
	var formattedLaunchDate: String {
		if let launchDate = launchDate {
			let formatter = DateFormatter()
			formatter.dateStyle = .long
			return formatter.string(from: launchDate)
		} else {
			return "N/A"
		}
	}
	
}
