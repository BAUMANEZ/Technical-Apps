//
//  PictureCell.swift
//  PryanikiParser
//
//  Created by Арсений Токарев on 04.03.2021.
//

import UIKit
import SnapKit

//MARK: - PICTURE CELL
class PictureCell: MainCell {
    static let cellIdentifier = "picture"
    private let pictureImageView = UIImageView()
    private let insideTextLabel = UILabel()
    private let labelsStackView = UIStackView()
    private let mainStackView = UIStackView()
    
    override func setViewModel(_ viewModel: ViewData) {
        super.setViewModel(viewModel)
        insideTextLabel.text = viewModel.data.text
        guard
            let url = viewModel.data.url,
            let image = getImage(from: url)
        else { return }
        pictureImageView.image = image
    }
    
    func getImage(from url: URL) -> UIImage? {
        guard let data = try? Data(contentsOf: url) else { return nil}
        return UIImage(data: data)
    }
    
    func configureLabels() {
        nameLabel.snp.removeConstraints()
        contentView.subviews.forEach { $0.removeFromSuperview() }
        insideTextLabel.styleLabel(font: .systemFont(ofSize: 18),
                                   textColor: .systemGray2,
                                   numberOfLines: 4)
        labelsStackView.styleStackView(spacing: 5,
                                       axis: .vertical,
                                       alignment: .leading,
                                       distribution: .fill)
        
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(insideTextLabel)
    }
    
    func configureStackViews() {
        configureLabels()
        mainStackView.styleStackView(spacing: 15,
                                     axis: .horizontal,
                                     alignment: .center,
                                     distribution: .fill)
        mainStackView.addArrangedSubview(labelsStackView)
        mainStackView.addArrangedSubview(pictureImageView)
        contentView.addSubview(mainStackView)
        pictureImageView.snp.makeConstraints { picturePosition in
            picturePosition.width.height.equalTo(80)
        }
        
        mainStackView.snp.makeConstraints { stackViewPosition in
            stackViewPosition.left.equalTo(20)
            stackViewPosition.top.equalTo(10)
            stackViewPosition.right.bottom.equalTo(-10)
        }
    }
    
    @objc func didTapCell() {
        let name = nameLabel.text ?? ""
        let pictureName = insideTextLabel.text ?? ""
        delegate?.didTapCell(with: name, description: "In the image you can see '\(pictureName)'")
    }
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        configureStackViews()
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(didTapCell))
        addGestureRecognizer(gestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
