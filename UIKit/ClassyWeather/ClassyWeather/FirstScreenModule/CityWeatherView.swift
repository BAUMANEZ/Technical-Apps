//
//  CityWeatherView.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 14.11.2020.
//

import UIKit

class CityWeatherView: UIView {
	private var weatherIcon = UIImageView()
	private var weatherStatusLabel = UILabel()
	private var cityNameLabel = UILabel()
	
	var fadeElements: Bool = false {
		didSet {
			if fadeElements {
				weatherIcon.alpha = 0
				weatherStatusLabel.alpha = 0
				cityNameLabel.alpha = 0
			} else {
				weatherIcon.alpha = 1
				weatherStatusLabel.alpha = 1
				cityNameLabel.alpha = 1
			}
		}
	}
	
	var weatherIconName: String = "search" {
		didSet {
			if let image = UIImage(named: weatherIconName) {
				weatherIcon.image = image
			}
		}
	}
	
	var weatherStatus: String = "What is the weather like today in..." {
		didSet {
			weatherStatusLabel.text = weatherStatus
		}
	}
	
	var cityName: String = "" {
		didSet {
			cityNameLabel.text = cityName
		}
	}
	
	func intro() {
		weatherIcon.transform = CGAffineTransform(rotationAngle: .pi)
		weatherStatusLabel.alpha = 1
		weatherStatusLabel.frame.origin.y -= 20
		weatherIcon.transform = CGAffineTransform(rotationAngle: 2 * .pi)
	}
	
	init() {
		super.init(frame: .zero)
		
		addSubview(weatherIcon)
		configureWeatherIcon()
		
		addSubview(weatherStatusLabel)
		configureWeatherStatusLabel()
		
		addSubview(cityNameLabel)
		configureCityNameLabel()
		
		NSLayoutConstraint.activate([
			weatherStatusLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
			weatherStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			weatherStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

			weatherIcon.bottomAnchor.constraint(equalTo: weatherStatusLabel.topAnchor, constant: -5),
			weatherIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
			weatherIcon.widthAnchor.constraint(equalToConstant: 100),
			weatherIcon.heightAnchor.constraint(equalTo: weatherIcon.widthAnchor),

			cityNameLabel.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: 5),
			cityNameLabel.leadingAnchor.constraint(equalTo: weatherStatusLabel.leadingAnchor, constant: 15),
			cityNameLabel.trailingAnchor.constraint(equalTo: weatherStatusLabel.trailingAnchor, constant: -15)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


extension CityWeatherView {
	private func configureWeatherIcon() {
		weatherIcon.translatesAutoresizingMaskIntoConstraints = false
		weatherIcon.contentMode = .scaleToFill
		if let image = UIImage(named: weatherIconName) {
			weatherIcon.image = image
		}
	}
	
	private func configureWeatherStatusLabel() {
		weatherStatusLabel.translatesAutoresizingMaskIntoConstraints = false
		defaultLabelConfiguration(for: weatherStatusLabel)
		weatherStatusLabel.text = weatherStatus
		weatherStatusLabel.adjustsFontSizeToFitWidth = true
		weatherStatusLabel.font = .systemFont(ofSize: 70, weight: .light)
		weatherStatusLabel.alpha = 0
	}
	
	private func configureCityNameLabel() {
		cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
		defaultLabelConfiguration(for: cityNameLabel, color: .cityColor)
		cityNameLabel.text = cityName
		cityNameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
	}
	
	private func defaultLabelConfiguration(for label: UILabel, color: UIColor = .navigationBarColor) {
		label.textAlignment = .center
		label.textColor = color
		label.adjustsFontSizeToFitWidth = true
	}
}
