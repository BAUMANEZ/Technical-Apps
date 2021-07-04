//
//  WeatherRequest.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 15.11.2020.
//

import UIKit
import CoreLocation

protocol WeatherNetworkRequest{
	func forecast(location: CLLocationCoordinate2D, completion: @escaping (WeatherBackendModel?) -> ())
}

final class WeatherRequest: WeatherNetworkRequest {
	private let API_KEY = "9064fad215badb077240847c0a9977f6"
	static let shared: WeatherNetworkRequest = WeatherRequest()
	
	func forecast(location: CLLocationCoordinate2D, completion: @escaping (WeatherBackendModel?) -> ()) {
		let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(location.latitude)&lon=\(location.longitude)&units=metric&exclude=minutely,alerts&appid=\(API_KEY)"
		 
		guard let url = URL(string: urlString) else {
			return
		}
		let request = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard error == nil else {
				completion(nil)
				return
			}
			guard let data = data, !data.isEmpty else {
				completion(nil)
				return
			}
			do {
				let weatherForecast = try JSONDecoder().decode(WeatherBackendModel.self, from: data)
				completion(weatherForecast)
			} catch {
				completion(nil)
			}
		}
		task.resume()

	}
	
	private init() {}
}
