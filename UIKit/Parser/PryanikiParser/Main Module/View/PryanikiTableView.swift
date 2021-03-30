//
//  PryanikiTableView.swift
//  PryanikiParser
//
//  Created by Арсений Токарев on 04.03.2021.
//

import UIKit

class PryanikiTableView: UITableView {

    init() {
        super.init(frame: .zero, style: .plain)
        registerCells()
        alwaysBounceVertical = false
        alwaysBounceHorizontal = false
        showsHorizontalScrollIndicator = false
        estimatedRowHeight = 100
        rowHeight = UITableView.automaticDimension
        tableFooterView = UIView()
        separatorColor = .selectedCellColor
    }
    
    func registerCells() {
        register(HzCell.self, forCellReuseIdentifier: HzCell.cellIdentifier)
        register(PictureCell.self, forCellReuseIdentifier: PictureCell.cellIdentifier)
        register(SelectorCell.self, forCellReuseIdentifier: SelectorCell.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
