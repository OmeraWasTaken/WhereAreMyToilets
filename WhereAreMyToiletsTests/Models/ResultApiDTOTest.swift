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
                           "nhits" : 617,
                             "records" : [
                               {
                                 "recordid" : "6abfc17e3d6e72b8fda24759466d031f7f9192f6",
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
                                 },
                                 "geometry" : {
                                   "type" : "Point",
                                   "coordinates" : [
                                     2.2682280857896977,
                                     48.8623619666065
                                   ]
                                 },
                                 "datasetid" : "sanisettesparis2011",
                                 "record_timestamp" : "2023-12-04T05:12:00.43Z"
                               },
                               {
                                 "recordid" : "02c2ea685a7a957801076f1ae18801587969995b",
                                 "fields" : {
                                   "geo_shape" : {
                                     "type" : "MultiPoint",
                                     "coordinates" : [
                                       [
                                         2.3372284244281887,
                                         48.842224100416587
                                       ]
                                     ]
                                   },
                                   "arrondissement" : 75006,
                                   "complement_adresse" : "numero_de_voie nom_de_voie",
                                   "acces_pmr" : "Oui",
                                   "geo_point_2d" : [
                                     48.842224100416587,
                                     2.3372284244281887
                                   ],
                                   "source" : "http://opendata.paris.fr",
                                   "gestionnaire" : "Toilette publique de la Ville de Paris",
                                   "adresse" : "AVENUE DE L OBSERVATOIRE",
                                   "horaire" : "6 h - 22 h",
                                   "type" : "SANISETTE"
                                 },
                                 "geometry" : {
                                   "type" : "Point",
                                   "coordinates" : [
                                     2.3372284244281887,
                                     48.842224100416587
                                   ]
                                 },
                                 "datasetid" : "sanisettesparis2011",
                                 "record_timestamp" : "2023-12-04T05:12:00.43Z"
                               }
                           ]
                           }
                           """.utf8)
        // WHEN
        // THEN
        XCTAssertNoThrow(try JSONDecoder().decode(ResultApiDTO.self, from: toilets))
    }
    
}
