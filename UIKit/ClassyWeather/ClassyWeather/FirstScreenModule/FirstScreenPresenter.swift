//
//  FirstScreenPresenter.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 14.11.2020.
//

import UIKit

enum WeatherPresentationStatus {
	case success, badConnection, cityNotFound
}

class FirstScreenPresenter {
	private weak var view: FirsrScreenDisplayLogic?
	
	init(view: FirsrScreenDisplayLogic) {
		self.view = view
	}
}

extension FirstScreenPresenter: FirstScreenPresentationLogic {
	func transferDataForRouter(data: WeatherBackendModel) {
		view?.getTransferDataForRouter(data)
	}
	
	func presentCityWeatherData(status: WeatherPresentationStatus, dataToTransfer data: Any?) {
		switch status {
		case .success:
			if let forecast = data as? WeatherBackendModel {
				let temperature = Int(forecast.current.temp)
				let weatherStatus = forecast.current.weather[0].main
				let shortWeatherInfo = "\(temperature)°, \(weatherStatus)"

				let timezone = forecast.timezone
				let city = timezone.components(separatedBy: "/")[1].uppercased().replacingOccurrences(of: "_", with: " ")
				let weatherIconName = weatherStatus.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
				view?.display(shortWeatherInfo, imageName: weatherIconName, in: city)
			}
		case .cityNotFound:
			view?.display("City not found", imageName: "cityNotFound", in: nil)
		case .badConnection:
			view?.display("Bad internet connection", imageName: "badInternetConnection", in: nil)
		}
	}
}
