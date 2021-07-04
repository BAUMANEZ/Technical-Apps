//
//  HeaderView.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 15.11.2020.
//

import UIKit

class CurrentWeatherView: UIView {
	private let weatherStatusLabel = UILabel()
	private let weatherIcon = UIImageView()
	private let temperatureLabel = UILabel()
	private let feelsLikeTextLabel = UILabel()
	private let humidityTextLabel = UILabel()
	private let windTextLabel = UILabel()
	private let visibilityTextLabel = UILabel()
	private let feelsLikeInfoLabel = UILabel()
	private let humidityInfoLabel = UILabel()
	private let windInfoLabel = UILabel()
	private let visibilityInfoLabel = UILabel()
	private let dailyForecastLabel = UILabel()
	
	var weatherComponent: Current? {
		didSet {
			guard let currentWeather = weatherComponent else { return }
			weatherStatusLabel.text = currentWeather.weather[0].description.uppercased()
			if let image = UIImage(named: currentWeather.weather[0].main.lowercased()) {
				weatherIcon.image = image
			}
			temperatureLabel.text = "\(Int(currentWeather.temp))°"
			feelsLikeInfoLabel.text = "\(Int(currentWeather.feels_like))°"
			humidityInfoLabel.text = "\(currentWeather.humidity)%"
			windInfoLabel.text = "\(currentWeather.wind_speed) Km/h"
			visibilityInfoLabel.text = "\(currentWeather.visibility / 1000) Km"
		}
	}
	
	init() {
		super.init(frame: .zero)
		configureTemperatureLabel()
		configureWeatherIcon()
		configureWeatherStatusLabel()
		configureDailyForecastLabel()
		configureDetailsLabels(components:
		   (label: feelsLikeTextLabel, text: "Feels like"),
		   (label: humidityTextLabel, text: "Humidity"),
		   (label: windTextLabel, text: "Wind"),
		   (label: visibilityTextLabel, text: "Visibility"),
		   (label: feelsLikeInfoLabel, text: ""),
		   (label: humidityInfoLabel, text: ""),
		   (label: windInfoLabel, text: ""),
		   (label: visibilityInfoLabel, text: "")
		)
		
		let detailsTextStack = UIStackView()
		detailsTextStack.styleStackView(spacing: 0, axis: .vertical)
		detailsTextStack.addArrangedSubview(feelsLikeTextLabel)
		detailsTextStack.addArrangedSubview(humidityTextLabel)
		detailsTextStack.addArrangedSubview(windTextLabel)
		detailsTextStack.addArrangedSubview(visibilityTextLabel)
		
		let detailsInfoStack = UIStackView()
		detailsInfoStack.styleStackView(spacing: 0, axis: .vertical)
		detailsInfoStack.addArrangedSubview(feelsLikeInfoLabel)
		detailsInfoStack.addArrangedSubview(humidityInfoLabel)
		detailsInfoStack.addArrangedSubview(windInfoLabel)
		detailsInfoStack.addArrangedSubview(visibilityInfoLabel)
		
		let detailsStack = UIStackView()
		detailsStack.styleStackView(spacing: 15, axis: .horizontal)
		detailsStack.addArrangedSubview(detailsTextStack)
		detailsStack.addArrangedSubview(detailsInfoStack)
		
		let mainStack = UIStackView()
		mainStack.styleStackView(spacing: 30, axis: .horizontal, distribution: .fill)
		mainStack.addArrangedSubview(temperatureLabel)
		mainStack.addArrangedSubview(detailsStack)
		mainStack.autoresizesSubviews = true
		
		addSubview(mainStack)
		addSubview(weatherIcon)
		addSubview(weatherStatusLabel)
		addSubview(dailyForecastLabel)
		frame.size.height = 450
		NSLayoutConstraint.activate([
			
			weatherStatusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			weatherStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
			weatherStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
			
			weatherIcon.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: 20),
			weatherIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
			weatherIcon.heightAnchor.constraint(equalToConstant: 150),
			weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor),
			
			mainStack.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 20),
			mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
			mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
			
			dailyForecastLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
			dailyForecastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension CurrentWeatherView {
	
	private func configureDailyForecastLabel() {
		dailyForecastLabel.font = .systemFont(ofSize: 18, weight: .semibold)
		dailyForecastLabel.text = "DAILY FORECAST"
		dailyForecastLabel.textColor = .navigationBarColor
		dailyForecastLabel.textAlignment = .left
		dailyForecastLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func configureDetailsLabels(components: (label: UILabel, text: String)...) {
		for component in components {
			component.label.text = component.text.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
			component.label.textColor = .navigationBarColor
			component.label.font = .systemFont(ofSize: 14, weight: .regular)
			component.label.textAlignment = .left
			component.label.adjustsFontSizeToFitWidth = true
			component.label.adjustsFontForContentSizeCategory = true
			component.label.translatesAutoresizingMaskIntoConstraints = false
		}
	}
	
	private func configureTemperatureLabel() {
		temperatureLabel.font = .systemFont(ofSize: 90, weight: .medium)
		temperatureLabel.textColor = .navigationBarColor
		temperatureLabel.textAlignment = .right
		temperatureLabel.adjustsFontSizeToFitWidth = true
		temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func configureWeatherIcon() {
		weatherIcon.translatesAutoresizingMaskIntoConstraints = false
		weatherIcon.contentMode = .redraw
	}
	
	private func configureWeatherStatusLabel() {
		weatherStatusLabel.translatesAutoresizingMaskIntoConstraints = false
		weatherStatusLabel.font = .systemFont(ofSize: 42, weight: .medium)
		weatherStatusLabel.adjustsFontSizeToFitWidth = true
		weatherStatusLabel.textColor = .navigationBarColor
		weatherStatusLabel.textAlignment = .center
	}
}
