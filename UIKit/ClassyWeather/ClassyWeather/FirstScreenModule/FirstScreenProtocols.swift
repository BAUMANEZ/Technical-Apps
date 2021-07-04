//
//  FirstScreenProtocols.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 18.11.2020.
//

import UIKit


protocol FirsrScreenDisplayLogic: class {
	func display(_ weatherStatus: String, imageName: String, in city: String?)
	func getTransferDataForRouter(_ routingData: WeatherBackendModel)
}

protocol FirstScreenBusinessLogic {
	func updateWeatherFor(location: String)
	func didTapCityWeatherView()
}

protocol FirstScreenPresentationLogic {
	func presentCityWeatherData(status: WeatherPresentationStatus, dataToTransfer data: Any?)
	func transferDataForRouter(data: WeatherBackendModel)
}

protocol FirstScreenRoutingLogic {
	func navigateToDetailedWeather(with weatherData: WeatherBackendModel)
}
