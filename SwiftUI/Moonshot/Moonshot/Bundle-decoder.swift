//
//  Bundle-descriptor.swift
//  Moonshot
//
//  Created by Арсений Токарев on 20.09.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import Foundation


extension Bundle {
	func decode<T: Codable>(_ file: String) -> T {
		
		//Step 1: search for file (URL - link) in the app bundle
		guard let url = self.url(forResource: file, withExtension: nil) else {
			fatalError("Failed to locate \(file) in bundle.")
		}
		
		//Step 2: load data from the linked file
		guard let data = try? Data.init(contentsOf: url) else {
			fatalError("Failed to load \(file) from bundle")
		}
		
		let decoder = JSONDecoder()
		let formated = DateFormatter()
		formated.dateFormat = "y-MM-dd"
		decoder.dateDecodingStrategy = .formatted(formated)
		
		//Step 3: decode this data to an array of T (any Type that conforms to Codable protocol)
		guard let loaded = try? decoder.decode(T.self, from: data) else {
			fatalError("Failed to decode \(file) from bundle.")
		}
		
		return loaded
	}
}
