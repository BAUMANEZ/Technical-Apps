//
//  UIStackViewExtenstion.swift
//  ClassyWeather
//
//  Created by Арсений Токарев on 15.11.2020.
//

import UIKit

extension UIStackView {
	func styleStackView(spacing: CGFloat, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fillEqually) {
		
		self.translatesAutoresizingMaskIntoConstraints = false
		self.axis = axis
		self.spacing = spacing
		self.distribution = distribution
	}
}
