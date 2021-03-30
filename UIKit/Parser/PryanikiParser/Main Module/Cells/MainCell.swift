//
//  PryanikiCell.swift
//  PryanikiParser
//
//  Created by Арсений Токарев on 04.03.2021.
//

import UIKit
import SnapKit

protocol MainCellProtocol: UITableViewCell {
    func setViewModel(_ viewModel: ViewData)
}

protocol CellTapDelegate {
    func didTapCell(with name: String, description: String)
}

class MainCell: UITableViewCell, MainCellProtocol {
    var delegate: CellTapDelegate?
    internal let nameLabel = UILabel()
    
    func setViewModel(_ viewModel: ViewData) {
        nameLabel.text = viewModel.name
    }
    
    func configureNameLabel() {
        nameLabel.styleLabel(font: .systemFont(ofSize: 36, weight: .bold),
                             textColor: .black,
                             numberOfLines: 2)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { nameLabelPosition in
            nameLabelPosition.left.equalTo(20)
            nameLabelPosition.right.equalTo(-10)
            nameLabelPosition.top.equalTo(10)
        }
    }

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        configureNameLabel()
        let selectedView = UIView()
        selectedView.backgroundColor = .selectedCellColor
        selectedView.layer.cornerRadius = 5
        selectedBackgroundView = selectedView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
