//
//  Logic (temporary).swift
//  ATM(Core Data)
//
//  Created by Арсений Токарев on 30.03.2021.
//

import Foundation

//MARK: - ATC
struct ATM {
    enum Currency {
        case RUB
        case USD
        case EUR

        var bills: [Int] {
            var bill = Set<Int>() // Protection from duplicates
            switch self {
            case .RUB:
                bill = [5000,
                        2000,
                        1000,
                        500,
                        100
                ]
            case .USD:
                bill = [100,
                        50,
                        20,
                        10,
                        5,
                        2,
                        1
                ]
            case .EUR:
                bill = [200,
                        100,
                        50,
                        20,
                        10,
                        5
                ]
            }
            return bill.sorted(by: >)
        }
        
        var symbol: String {
            switch self {
            case .RUB:
                return "₽"
            case .USD:
                return "$"
            case .EUR:
                return "€"
            }
        }
    }
    private(set) var total: [Currency : Int] = [:]
    
    mutating func insert(cash insertedCash: Int, in currency: Currency) {
        let currentCash = total[currency] ?? 0
        total.updateValue(currentCash + insertedCash, forKey: currency)
    }
    
    mutating func withdraw(cash cashToGive: Int, in currency: Currency) {
        guard
            let totalCashInCurrency = total[currency],
            cashToGive <= totalCashInCurrency
        else {
            printCash(bills: [], symbol: nil, failureMessage: "Not sufficient money in ATM")
            return
        }
        total.updateValue(totalCashInCurrency - cashToGive, forKey: currency)
        var billsToPrint = [Int]()
        var cashToGive = cashToGive
        for bill in currency.bills {
            let numberOfBills = cashToGive / bill
            billsToPrint += [Int](repeating: bill, count: numberOfBills)
            cashToGive -= numberOfBills * bill
        }
        printCash(bills: billsToPrint, symbol: currency.symbol, failureMessage: nil)
    }
    
    mutating func convert(_ first: Currency, into second: Currency) {
        //everything goes throw dollar
    }
    
    private func printCash(bills: [Int], symbol: String?, failureMessage: String?) {
        if let error = failureMessage {
            //ATM.label.text = error
            print(error)
            return
        }
        let symbol = symbol ?? ""
        bills.forEach { print("\($0)\(symbol)") }
    }
    
    init(total: [Currency : Int]) {
        self.total = total
    }
}
