//
//  ResultApiDTOTest.swift
//  WhereAreMyToiletsTests
//
//  Created by Quentin Richard on 16/12/2023.
//

import XCTest
@testable import WhereAreMyToilets

final class ResultApiDTOTest: XCTestCase {
    func testDecodingToiletsInformationSucced() throws {
        // GIVEN
        let toilets = Data("""
                           {
                           "nhits": 617,
                           "records": [
                           {
                           "type": "SANISETTE",
                           "statut":null,
                           "adresse":"BOULEVARD SUCHET",
                           "arrondissement":75016,
                           "horaire":"6 h - 22 h",
                           "acces_pmr":"Oui",
                           "relais_bebe":null,
                           "url_fiche_equipement":null,
                           "geo_shape":{
                           "type":"Feature",
                           "geometry":{
                           "coordinates":[
                           [
                           2.2682280857896977,
                           48.8623619666065
                           ]
                           ],
                           "type":"MultiPoint"
                           },
                           "properties":{
                           }
                           },
                           "geo_point_2d":{
                           "lon":2.2682280857896977,
                           "lat":48.8623619666065
                           },
                           "gestionnaire":"Toilette publique de la Ville de Paris",
                           "source":"http://opendata.paris.fr",
                           "complement_adresse":"numero_de_voie nom_de_voie"
                           }
                           ]
                           }
                           """.utf8)
           // WHEN
           // THEN
           XCTAssertNoThrow(try JSONDecoder().decode(ResultApiDTO.self, from: toilets))
       }

}
