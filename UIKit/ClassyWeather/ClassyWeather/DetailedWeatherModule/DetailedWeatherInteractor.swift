//
//  DetailedWeatherInteractor.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 17.11.2020.
//  Copyright (c) 2020. All rights reserved.

import UIKit

class DetailedWeatherInteractor: DetailedWeatherDataStore {
	var weatherModel: WeatherBackendModel?
	var presenter: DetailedWeatherPresentationLogic?
}

extension DetailedWeatherInteractor: DetailedWeatherBusinessLogic {
	func fetchWeatherData() {
		if let weatherModel = weatherModel {
			presenter?.presentDetailedWeatherData(weatherModel)
		}
	}
}
