//
//  ResultApiDTO.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import Foundation

struct ResultApiDTO: Decodable, Equatable {
    let numberOfItem: Int
    let records: [ToiletsDTO]
    
    enum CodingKeys: String, CodingKey {
        case numberOfItem = "nhits"
        case records = "records"
    }
    
    init(from decoder: Decoder) throws {
        let decodedValue = try decoder.container(keyedBy: CodingKeys.self)
        self.numberOfItem = try decodedValue.decode(Int.self, forKey: .numberOfItem)
        self.records = try decodedValue.decode([ToiletsDTO].self, forKey: .records)
    }
    
    init(numberOfItem: Int, records: [ToiletsDTO]) {
        self.numberOfItem = numberOfItem
        self.records = records
    }
}
