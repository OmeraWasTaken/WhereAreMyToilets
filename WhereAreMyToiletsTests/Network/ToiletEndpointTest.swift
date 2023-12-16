//
//  ToiletEndpointTest.swift
//  WhereAreMyToiletsTests
//
//  Created by Quentin Richard on 16/12/2023.
//

import XCTest
@testable import WhereAreMyToilets

final class ToiletEndpointTest: XCTestCase {
    
    func testGetUrl() {
        // GIVEN
        let expectedUrl = "https://data.ratp.fr/api/records/1.0/search/?dataset=sanisettesparis2011&start=0&rows=100"
        let urlToTest = ToiletEndpoint.toiletsLocation(start: "0").url
        // WHEN
        // THEN
        XCTAssertEqual(urlToTest?.absoluteString, expectedUrl)
    }
}
