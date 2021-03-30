//
//  SelectorCell.swift
//  PryanikiParser
//
//  Created by Арсений Токарев on 04.03.2021.
//

import UIKit
import SnapKit

//MARK: - SELECTOR CELL
class SelectorCell: MainCell {
    static let cellIdentifier = "selector"
    private var itemsInPicker = [Variant]()
    private let pickerView = UIPickerView()
    
    override func setViewModel(_ viewModel: ViewData) {
        super.setViewModel(viewModel)
        guard
            let selectedId = viewModel.data.selectedId,
            let variants = viewModel.data.variants
        else {
            return
        }
        itemsInPicker = variants
        if let selectedItemIndex = variants.firstIndex(where: { $0.id == selectedId }) {
            pickerView.selectRow(selectedItemIndex, inComponent: pickerView.numberOfComponents - 1,
                                 animated: false)
        }
    }
    
    func configurePickerView() {
        contentView.addSubview(pickerView)
        pickerView.snp.makeConstraints { pickerViewPosition in
            pickerViewPosition.top.equalTo(nameLabel.snp.bottom).inset(-10)
            pickerViewPosition.bottom.equalToSuperview().offset(-10)
            pickerViewPosition.left.right.equalTo(nameLabel)
        }
    }
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        configurePickerView()
        selectedBackgroundView = UIView()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SelectorCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return itemsInPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        itemsInPicker[row].text
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        let item = itemsInPicker[row]
        let itemText = item.text
        let itemId = item.id
        let name = nameLabel.text ?? ""
        delegate?.didTapCell(with: name, description: "You have chosen '\(itemText)' in a picker with id '\(itemId)'")
    }
}
