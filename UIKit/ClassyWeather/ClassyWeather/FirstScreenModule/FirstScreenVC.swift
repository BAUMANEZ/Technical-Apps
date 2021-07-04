//
//  SearchAndShorthandInfoVC.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 14.11.2020.
//

import UIKit

class SearchAndShorthandInfoVC: UIViewController {
	private let cityWeatherView = CityWeatherView()
	private let searchBar = UISearchBar()
	var interactor: FirstScreenBusinessLogic?
	var router: FirstScreenRoutingLogic?
	
	override func loadView() {
		super.loadView()
		
		view = cityWeatherView
		
		configureNavController()
		configureSearchBar()
		
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .backgroundColor
		searchBar.delegate = self
		cityWeatherView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapWeatherView)))
		cityWeatherView.isUserInteractionEnabled = false
		
		UIView.animate(withDuration: 0.75, delay: 0.15, options: .curveEaseInOut, animations: {
			self.cityWeatherView.intro()
		})
    }
	
	@objc func didTapWeatherView(_ sender: UITapGestureRecognizer) {
		interactor?.didTapCityWeatherView()
	}
	
	func configureNavController() {
		navigationController?.overrideUserInterfaceStyle = .dark
		navigationController?.navigationBar.barTintColor = .navigationBarColor
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.tintColor = .white
	
	}
	
	func configureSearchBar() {
		searchBar.sizeToFit()
		searchBar.placeholder = "Weather in..."
		searchBar.tintColor = .white
		searchBar.keyboardType = .alphabet
		navigationController?.navigationBar.topItem?.titleView = searchBar
	}

}

extension SearchAndShorthandInfoVC: FirsrScreenDisplayLogic {
	func getTransferDataForRouter(_ routingData: WeatherBackendModel) {
		router?.navigateToDetailedWeather(with: routingData)
	}
	
	func display(_ weatherStatus: String, imageName: String, in city: String?) {
		guard cityWeatherView.weatherStatus != weatherStatus || cityWeatherView.cityName != city else { return}
		DispatchQueue.main.async {
			UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
				self.cityWeatherView.fadeElements.toggle()
			}) { _ in
				self.cityWeatherView.weatherStatus = weatherStatus
				self.cityWeatherView.weatherIconName = imageName
				if let city = city, !city.isEmpty {
					self.cityWeatherView.cityName = city
					self.cityWeatherView.isUserInteractionEnabled = true
				} else {
					self.cityWeatherView.isUserInteractionEnabled = false
					self.cityWeatherView.cityName = ""
				}
				UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
					self.cityWeatherView.fadeElements.toggle()
				})
			}
		}
	}
}

extension SearchAndShorthandInfoVC: UISearchBarDelegate {
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		searchBar.showsCancelButton = false
	}
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.showsCancelButton = true
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		searchBar.showsCancelButton = false
	}
	
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText != "" {
			interactor?.updateWeatherFor(location: searchText)
		} else {
			UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
				self.cityWeatherView.fadeElements.toggle()
			}) { _ in
				self.cityWeatherView.isUserInteractionEnabled = false
				self.cityWeatherView.cityName = ""
				self.cityWeatherView.weatherStatus = "What is the weather like today in..."
				self.cityWeatherView.weatherIconName = "search"
				UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
					self.cityWeatherView.fadeElements.toggle()
				})
			}
		}
	}
}

