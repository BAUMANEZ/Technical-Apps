//
//  Parser.swift
//  PryanikiParser
//
//  Created by Арсений Токарев on 04.03.2021.
//

import UIKit
import Alamofire

enum ParsingError: Error {
    case couldnotParseData
}

protocol ParsingProtocol {
    func parseData(completion: @escaping (Result<PryanikiResponse, ParsingError>) -> ())
}

class PryanikiRequest: ParsingProtocol {
    public static let shared: ParsingProtocol = PryanikiRequest()
    private let urlToParseFrom = "https://chat.pryaniky.com/json/data-custom-order-much-more-items-in-data.json"
    
    func parseData(completion: @escaping (Result<PryanikiResponse, ParsingError>) -> ()) {
        AF.request(urlToParseFrom)
            .validate()
            .responseDecodable(of: PryanikiResponse.self) { response in
                guard let parsedData = response.value else {
                    completion(.failure(.couldnotParseData))
                    return
                }
                completion(.success(parsedData))
            }
    }
    
    private init() {}
}
