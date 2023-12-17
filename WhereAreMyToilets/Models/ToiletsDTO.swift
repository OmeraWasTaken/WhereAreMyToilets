//
//  ToiletsDTO.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import CoreLocation

struct ToiletsDTO: Decodable, Equatable {
    let fields: FieldsDTO
    
    enum CodingKeys: String, CodingKey {
        case fields = "fields"
    }
    
    init(from decoder: Decoder) throws {
        let decodedValue = try decoder.container(keyedBy: CodingKeys.self)
        self.fields = try decodedValue.decode(FieldsDTO.self, forKey: .fields)
    }
}
