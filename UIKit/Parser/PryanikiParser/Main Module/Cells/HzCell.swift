//
//  HzCell.swift
//  PryanikiParser
//
//  Created by Арсений Токарев on 04.03.2021.
//

import UIKit
import SnapKit

//MARK: - HZ CELL
class HzCell: MainCell {
    static let cellIdentifier = "hz"
    private let insideTextLabel = UILabel()
    
    override func setViewModel(_ viewModel: ViewData) {
        super.setViewModel(viewModel)
        insideTextLabel.textAlignment = .justified
        insideTextLabel.text = viewModel.data.text
    }
    
    func configureTextLabel() {
        contentView.addSubview(insideTextLabel)
        insideTextLabel.styleLabel(font: .systemFont(ofSize: 18),
                                   textColor: .systemGray2,
                                   numberOfLines: 0)
        insideTextLabel.snp.makeConstraints { insideTextLabelPosition in
            insideTextLabelPosition.top.equalTo(nameLabel.snp.bottom).offset(5)
            insideTextLabelPosition.right.equalTo(nameLabel.snp.right)
            insideTextLabelPosition.left.equalTo(nameLabel.snp.left)
            insideTextLabelPosition.bottom.equalTo(-10)
        }
    }
    
    @objc func didTapCell() {
        let name = nameLabel.text ?? ""
        let text = insideTextLabel.text ?? ""
        delegate?.didTapCell(with: name, description: "I have the following text: '\(text)'")
    }
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        configureTextLabel()
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(didTapCell))
        addGestureRecognizer(gestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
