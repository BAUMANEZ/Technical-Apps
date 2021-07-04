//
//  FirstScreenRouter.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 14.11.2020.
//

import UIKit

class FirstClassRouter {
	weak var viewController: UIViewController?
}

extension FirstClassRouter: FirstScreenRoutingLogic {
	func navigateToDetailedWeather(with weatherData: WeatherBackendModel) {
		let detailedWeatherVC = DetailedWeatherModule.build()
		detailedWeatherVC.router?.dataStore?.weatherModel = weatherData
		viewController?.navigationController?.pushViewController(detailedWeatherVC, animated: true)
	}
}
