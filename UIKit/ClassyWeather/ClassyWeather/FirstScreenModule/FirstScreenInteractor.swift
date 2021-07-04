//
//  FirstScreenInteractor.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 14.11.2020.
//

import UIKit
import CoreLocation

class FirstScreenInteractor {
	private let presenter: FirstScreenPresenter
	var forecastData: WeatherBackendModel?
	
	init(presenter: FirstScreenPresenter) {
		self.presenter = presenter
	}
}

extension FirstScreenInteractor: FirstScreenBusinessLogic {
	func didTapCityWeatherView() {
		guard let forecastData = forecastData else { return }
		presenter.transferDataForRouter(data: forecastData)
	}
	
	func updateWeatherFor(location: String) {
		CLGeocoder().geocodeAddressString(location) { (placemarks: [CLPlacemark]?, error: Error?) in
			switch error {
			case .none:
				if let location = placemarks?.first?.location {
					WeatherRequest.shared.forecast(location: location.coordinate) { (forecastData) -> () in
						guard let forecastData = forecastData else {
							self.presenter.presentCityWeatherData(status: .cityNotFound, dataToTransfer: nil)
							return
						}
						self.forecastData = forecastData
						self.presenter.presentCityWeatherData(status: .success, dataToTransfer: forecastData)
					}
				}
			case .some(CLError.network):
				self.presenter.presentCityWeatherData(status: .badConnection, dataToTransfer: nil)
			default:
				self.presenter.presentCityWeatherData(status: .cityNotFound, dataToTransfer: nil)
			}
			 
		}
	}
	
	
}
