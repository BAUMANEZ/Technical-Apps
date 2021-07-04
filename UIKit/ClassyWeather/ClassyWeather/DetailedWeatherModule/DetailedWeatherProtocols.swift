//
//  DetailedWeatherProtocols.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 17.11.2020.
//

import UIKit

protocol DetailedWeatherDisplayLogic: class {
	var cellsToDisplay: [UITableViewCell] { get set }
	func display(weather: WeatherBackendModel)
}

protocol DetailedWeatherBusinessLogic {
	func fetchWeatherData()
}

protocol DetailedWeatherDataStore: class {
	var weatherModel: WeatherBackendModel? { get set }
}

protocol DetailedWeatherPresentationLogic {
	func presentDetailedWeatherData(_ data: WeatherBackendModel)
}

protocol DetailedWeatherRoutingLogic {
	
}

protocol DetailedWeatherDataPassing {
	var dataStore: DetailedWeatherDataStore? { get }
}
