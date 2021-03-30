//
//  PryanikiViewModel.swift
//  PryanikiParser
//
//  Created by Арсений Токарев on 04.03.2021.
//

import Foundation

class PryanikiViewModel {
    private(set) var pryanikiResponse: PryanikiResponse? {
        didSet {
            bindViewModelToView?()
        }
    }
    
    var bindViewModelToView: (() -> ())?
    
    public init(model: PryanikiResponse? = nil) {
        if let model = model {
            pryanikiResponse = model
        } else {
            PryanikiRequest.shared.parseData { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let parsedData):
                    self.pryanikiResponse = parsedData
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}
