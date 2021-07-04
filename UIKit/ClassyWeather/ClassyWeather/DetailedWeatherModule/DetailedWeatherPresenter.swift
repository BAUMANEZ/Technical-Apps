//
//  DetailedWeatherPresenter.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 17.11.2020.
//  Copyright (c) 2020. All rights reserved.

import UIKit

class DetailedWeatherPresenter {
	
	weak var viewController: DetailedWeatherDisplayLogic?
	
}

extension DetailedWeatherPresenter: DetailedWeatherPresentationLogic {
	func presentDetailedWeatherData(_ weather: WeatherBackendModel) {
		viewController?.display(weather: weather)
	}
}
