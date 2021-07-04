//
//  DetailedWeatherConfigurator.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 17.11.2020.
//

import UIKit

class DetailedWeatherModule {
	static func build() -> DetailedWeatherTableVC {
		let viewController = DetailedWeatherTableVC()
		let interactor = DetailedWeatherInteractor()
		
		let presenter = DetailedWeatherPresenter()
		presenter.viewController = viewController
		
		let router = DetailedWeatherRouter()
		router.viewController = viewController
		viewController.router = router
		
		interactor.presenter = presenter
		router.dataStore = interactor
		viewController.interactor = interactor
		
		
		
		return viewController
	}
}
