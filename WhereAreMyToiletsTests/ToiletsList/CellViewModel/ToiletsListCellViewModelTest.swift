//
//  ToiletsListCellViewModelTest.swift
//  WhereAreMyToiletsTests
//
//  Created by Quentin Richard on 17/12/2023.
//

import XCTest
import CoreLocation
@testable import WhereAreMyToilets

final class ToiletsListCellViewModelTest: XCTestCase {
    func testGetAddress() {
        // GIVEN
        let sut = ToiletsListCellViewModel(address: "12 rue des oranges",
                                           district: 75012,
                                           schedule: "",
                                           accessPrm: "",
                                           localisation: [],
                                           currentLocalisation: CLLocation(latitude: 0, longitude: 0))
        // WHEN
        let address = sut.getAddress()
        // THEN
        XCTAssertEqual(address, "12 rue des oranges 75012")
    }
    
    func testGetScheduleWhenScheduleGiven() {
        let sut = ToiletsListCellViewModel(address: "",
                                           district: 0,
                                           schedule: "6 h - 12h",
                                           accessPrm: "",
                                           localisation: [],
                                           currentLocalisation: CLLocation(latitude: 0, longitude: 0))
        // WHEN
        let schedule = sut.getSchedule()
        // THEN
        XCTAssertEqual(schedule, "6 h - 12h")
    }
    
    func testGetScheduleWhenScheduleIsNil() {
        let sut = ToiletsListCellViewModel(address: "",
                                           district: 0,
                                           schedule: nil,
                                           accessPrm: "",
                                           localisation: [],
                                           currentLocalisation: CLLocation(latitude: 0, longitude: 0))
        // WHEN
        let schedule = sut.getSchedule()
        // THEN
        XCTAssertEqual(schedule, "Nous n'avons pas les horaires d'ouverture pour ces toilettes.")
    }

    func testGetAccessPrm() {
        let sut = ToiletsListCellViewModel(address: "",
                                           district: 0,
                                           schedule: nil,
                                           accessPrm: "Oui",
                                           localisation: [],
                                           currentLocalisation: CLLocation(latitude: 0, longitude: 0))
        // WHEN
        let accessPrm = sut.accessPrm
        // THEN
        XCTAssertEqual(accessPrm, "Oui")
    }
    
    func testGetDistanceWhenCurrentLocationGiven() {
        let sut = ToiletsListCellViewModel(address: "",
                                           district: 0,
                                           schedule: nil,
                                           accessPrm: "Oui",
                                           localisation: [0, 0],
                                           currentLocalisation: CLLocation(latitude: 0, longitude: 0))
        // WHEN
        let distance = sut.getLocalisation()
        // THEN
        XCTAssertEqual(distance, "0.00")
    }
    
    func testGetDistanceWhenCurrentLocationNotGiven() {
        let sut = ToiletsListCellViewModel(address: "",
                                           district: 0,
                                           schedule: nil,
                                           accessPrm: "Oui",
                                           localisation: [0, 0],
                                           currentLocalisation: nil)
        // WHEN
        let distance = sut.getLocalisation()
        // THEN
        XCTAssertEqual(distance, "Nous ne pouvons pas vous donner la distance entre vous et les toilettes sans votre localisation")
    }

}
