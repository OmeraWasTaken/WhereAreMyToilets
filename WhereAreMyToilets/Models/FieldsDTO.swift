//
//  FieldsDTO.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import Foundation


struct FieldsDTO: Decodable, Equatable {
    let schedule: String?
    let coordinates: [Float]
    let adress: String?
    let district: Int
    let accessPrm: String
    
    enum CodingKeys: String, CodingKey {
        case schedule = "horaire"
        case coodinates = "geo_point_2d"
        case adress = "adresse"
        case district = "arrondissement"
        case accessPrm = "acces_pmr"
    }
    
    init(from decoder: Decoder) throws {
        let decodedValue = try decoder.container(keyedBy: CodingKeys.self)
        self.schedule = try? decodedValue.decode(String.self, forKey: .schedule)
        self.coordinates = try decodedValue.decode([Float].self, forKey: .coodinates)
        self.adress = try? decodedValue.decode(String.self, forKey: .adress)
        self.district = try decodedValue.decode(Int.self, forKey: .district)
        self.accessPrm = try decodedValue.decode(String.self, forKey: .accessPrm)
    }
}
