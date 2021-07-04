//
//  DetailedWeatherVC.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 17.11.2020.
//  Copyright (c) 2020. All rights reserved.
//

import UIKit

class DetailedWeatherTableVC: UITableViewController {
	private let currentWeatherView = CurrentWeatherView()
	internal var cellsToDisplay = [UITableViewCell]()
	
	var interactor: DetailedWeatherBusinessLogic?
	var router: (DetailedWeatherRoutingLogic & DetailedWeatherDataPassing)?
	override func loadView() {
		super.loadView()
		configureTableView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		interactor?.fetchWeatherData()
	}
	
	func configureTableView() {
		
		tableView.tableHeaderView = currentWeatherView
		tableView.backgroundColor = .backgroundColor
		tableView.allowsSelection = false
		tableView.estimatedRowHeight = 55
		tableView.rowHeight = UITableView.automaticDimension
		tableView.register(DailyForecastCell.self, forCellReuseIdentifier: DailyForecastCell.cellIdentifier)
	}

	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		1
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellsToDisplay.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		cellsToDisplay[indexPath.row]
	}
}


extension DetailedWeatherTableVC: DetailedWeatherDisplayLogic {
	func display(weather: WeatherBackendModel){
		let timezone = weather.timezone
		let city = timezone.components(separatedBy: "/")[1].uppercased().replacingOccurrences(of: "_", with: " ")
		navigationItem.title = city
		currentWeatherView.weatherComponent = weather.current
		for dailyComponent in weather.daily {
			if let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastCell.cellIdentifier) as? DailyForecastCell {
				cell.dayViewModel = dailyComponent
				cellsToDisplay.append(cell)
			}
		}
		
		tableView.reloadData()
	}
}
