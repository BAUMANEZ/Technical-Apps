//
//  Extensions.swift
//  PryanikiParser
//
//  Created by Арсений Токарев on 04.03.2021.
//

import UIKit

//MARK: - LABELS
extension UILabel {
    func styleLabel(font: UIFont,
                    textColor: UIColor,
                    numberOfLines: Int) {
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.textAlignment = .justified
    }
}

//MARK: - STACK VIEWS
extension UIStackView {
    func styleStackView(spacing: CGFloat,
                        axis: NSLayoutConstraint.Axis,
                        alignment: Alignment,
                        distribution: Distribution = .fillProportionally) {
        self.spacing = spacing
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        
    }
}
