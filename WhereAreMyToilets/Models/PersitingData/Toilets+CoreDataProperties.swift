//
//  Toilets+CoreDataProperties.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//
//

import Foundation
import CoreData


extension Toilets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Toilets> {
        return NSFetchRequest<Toilets>(entityName: "Toilets")
    }

    @NSManaged public var adress: String?
    @NSManaged public var district: Int64
    @NSManaged public var accessPrm: String?
    @NSManaged public var lat: Float
    @NSManaged public var lon: Float
    @NSManaged public var schedule: String?
    @NSManaged public var numberOfItem: Int64

}

extension Toilets : Identifiable {

}
