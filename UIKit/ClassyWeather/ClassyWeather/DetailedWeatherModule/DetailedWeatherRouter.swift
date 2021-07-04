//
//  DetailedWeatherRouter.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 17.11.2020.
//  Copyright (c) 2020. All rights reserved.

import UIKit

class DetailedWeatherRouter: DetailedWeatherDataPassing {
	
	weak var viewController: DetailedWeatherTableVC?
	weak var dataStore: DetailedWeatherDataStore?
  
}

extension DetailedWeatherRouter: DetailedWeatherRoutingLogic {
	
}
