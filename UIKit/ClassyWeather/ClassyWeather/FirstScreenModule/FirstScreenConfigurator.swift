//
//  FirstScreenConfigurator.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 14.11.2020.
//

import UIKit

class FirstScreenConfigurator {
	static func build() -> SearchAndShorthandInfoVC {
		let viewController = SearchAndShorthandInfoVC()
		let presenter = FirstScreenPresenter(view: viewController)
		let interactor = FirstScreenInteractor(presenter: presenter)
		viewController.interactor = interactor
		let router = FirstClassRouter()
		router.viewController = viewController
		viewController.router = router
		
		return viewController
	}
}
