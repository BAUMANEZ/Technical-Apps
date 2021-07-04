//
//  DailyForecastCell.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 15.11.2020.
//

import UIKit

class DailyForecastCell: UITableViewCell {
	static let cellIdentifier = "DailyForecastCell"
	
	private let dayLabel = UILabel()
	private let maxTemperatureLabel = UILabel()
	private let minTemperatureLabel = UILabel()
	private let weatherIcon = UIImageView()
	
	var dayViewModel: Daily? {
		didSet {
			guard let dayViewModel = dayViewModel else { return }
			if let image = UIImage(named: dayViewModel.weather[0].main.lowercased()) {
				weatherIcon.image = image
			}
			
			maxTemperatureLabel.text = "\(Int(dayViewModel.temp.max))°"
			minTemperatureLabel.text = "\(Int(dayViewModel.temp.min))°"
			
			let date = Date(timeIntervalSince1970: TimeInterval(dayViewModel.dt))
			let day = Calendar.current.dateComponents([.day], from: date)
			if day == Calendar.current.dateComponents([.day], from: Date()) {
				dayLabel.text = "TODAY"
				return
			}
			let formatter = DateFormatter()
			formatter.dateFormat = "eeee"
			dayLabel.text = formatter.string(from: date).uppercased()
		}
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .white
		configureWeatherIcon()
		configureDailyWeatherLabel(label: dayLabel)
		configureTemperatureLabel(label: maxTemperatureLabel)
		configureTemperatureLabel(label: minTemperatureLabel, color: UIColor.navigationBarColor.withAlphaComponent(0.5))
		
		let weatherInfoStack = UIStackView()
		weatherInfoStack.styleStackView(spacing: 10, axis: .horizontal)
		weatherInfoStack.addArrangedSubview(maxTemperatureLabel)
		weatherInfoStack.addArrangedSubview(minTemperatureLabel)
		
		addSubview(weatherIcon)
		addSubview(dayLabel)
		addSubview(weatherInfoStack)
		
		NSLayoutConstraint.activate([
			weatherIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
			weatherIcon.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			weatherIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
			weatherIcon.heightAnchor.constraint(equalToConstant: 50),
			weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor),
			
			dayLabel.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor, constant: 15),
			dayLabel.topAnchor.constraint(equalTo: weatherIcon.topAnchor),
			dayLabel.bottomAnchor.constraint(equalTo: weatherIcon.bottomAnchor),
			
			weatherInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
			weatherInfoStack.topAnchor.constraint(equalTo: weatherIcon.topAnchor),
			weatherInfoStack.bottomAnchor.constraint(equalTo: weatherIcon.bottomAnchor)
			
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


extension DailyForecastCell {
	private func configureWeatherIcon() {
		weatherIcon.contentMode = .scaleAspectFit
		weatherIcon.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func configureDailyWeatherLabel(label: UILabel) {
		label.textColor = .navigationBarColor
		label.font = .systemFont(ofSize: 14, weight: .light)
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func configureTemperatureLabel(label: UILabel, color: UIColor = .navigationBarColor) {
		label.textColor = color
		label.font = .systemFont(ofSize: 14, weight: .bold)
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .right
		label.translatesAutoresizingMaskIntoConstraints = false
	}
}
