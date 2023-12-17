//
//  ToiletsDTOTest.swift
//  WhereAreMyToiletsTests
//
//  Created by Quentin Richard on 16/12/2023.
//

import XCTest
@testable import WhereAreMyToilets

final class ToiletsDTOTest: XCTestCase {
    func testDecodingToiletsInformationSucced() throws {
        // GIVEN
        let toilets = Data("""
                           {
                           "fields" : {
                           "geo_shape" : {
                             "type" : "MultiPoint",
                             "coordinates" : [
                               [
                                 2.2682280857896977,
                                 48.8623619666065
                               ]
                             ]
                           },
                           "arrondissement" : 75016,
                           "complement_adresse" : "numero_de_voie nom_de_voie",
                           "acces_pmr" : "Oui",
                           "geo_point_2d" : [
                             48.8623619666065,
                             2.2682280857896977
                           ],
                           "source" : "http://opendata.paris.fr",
                           "gestionnaire" : "Toilette publique de la Ville de Paris",
                           "adresse" : "BOULEVARD SUCHET",
                           "horaire" : "6 h - 22 h",
                           "type" : "SANISETTE"
                           }
                           }
                           """.utf8)
           // WHEN
           // THEN
           XCTAssertNoThrow(try JSONDecoder().decode(ToiletsDTO.self, from: toilets))
       }

}
