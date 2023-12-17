//
//  ToiletDetailsViewModelTest.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import Foundation

import XCTest
import CoreLocation
@testable import WhereAreMyToilets

final class ToiletDetailsViewModelTest: XCTestCase {
    func testGetTitle() {
        // GIVEN
        let sut = ToiletDetailsViewModel(field: FieldsDTO(schedule: nil,
                                                          coordinates: [],
                                                          adress: "12 rue des oranges",
                                                          district: 75012,
                                                          accessPrm: nil))
        // WHEN
        let title = sut.title
        // THEN
        XCTAssertEqual(title, "Details de vos toilettes")
    }
    
    func testGetDescription() {
        // GIVEN
        let sut = ToiletDetailsViewModel(field: FieldsDTO(schedule: nil,
                                                          coordinates: [],
                                                          adress: "12 rue des oranges",
                                                          district: 75012,
                                                          accessPrm: nil))
        // WHEN
        let desctiption = sut.description
        // THEN
        XCTAssertEqual(desctiption, "Il y a pas beaucoup d'informations supplementaires ici du coup je mets un petit message pour que ca fasse pas trop vide non plus")
    }


    func testGetAddress() {
        // GIVEN
        let sut = ToiletDetailsViewModel(field: FieldsDTO(schedule: nil,
                                                          coordinates: [],
                                                          adress: "12 rue des oranges",
                                                          district: 75012,
                                                          accessPrm: nil))
        // WHEN
        let address = sut.getAddress()
        // THEN
        XCTAssertEqual(address, "Addresse de toilettes: 12 rue des oranges 75012")
    }
    
    func testGetScheduleWhenScheduleGiven() {
        let sut = ToiletDetailsViewModel(field: FieldsDTO(schedule: "6 h - 12h",
                                                          coordinates: [],
                                                          adress: "12 rue des oranges",
                                                          district: 75012,
                                                          accessPrm: nil))
        // WHEN
        let schedule = sut.getSchedule()
        // THEN
        XCTAssertEqual(schedule, "Les horaires d'ouverture: 6 h - 12h")
    }
    
    func testGetScheduleWhenScheduleIsNil() {
        let sut = ToiletDetailsViewModel(field: FieldsDTO(schedule: nil,
                                                          coordinates: [],
                                                          adress: "12 rue des oranges",
                                                          district: 75012,
                                                          accessPrm: nil))
        // WHEN
        let schedule = sut.getSchedule()
        // THEN
        XCTAssertEqual(schedule, "Nous n'avons pas les horaires d'ouverture pour ces toilettes.")
    }
    
    func testGetAccessPrm() {
        let sut = ToiletDetailsViewModel(field: FieldsDTO(schedule: nil,
                                                          coordinates: [],
                                                          adress: "12 rue des oranges",
                                                          district: 75012,
                                                          accessPrm: "Oui"))
        // WHEN
        let accessPrm = sut.getAccessPrm()
        // THEN
        XCTAssertEqual(accessPrm, "Accessible pour les personnes a mobilité reduite: Oui")
    }
    
    func testGetAccessPrmWithoutInformation() {
        let sut = ToiletDetailsViewModel(field: FieldsDTO(schedule: nil,
                                                          coordinates: [],
                                                          adress: "12 rue des oranges",
                                                          district: 75012,
                                                          accessPrm: nil))
        // WHEN
        let accessPrm = sut.getAccessPrm()
        // THEN
        XCTAssertEqual(accessPrm, "Nous ne savons pas si ses toilettes sont accessible au personne a mobilité reduite")
    }

}
