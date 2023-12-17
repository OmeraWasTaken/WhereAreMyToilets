//
//  ToiletsPersistingValue.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import CoreData
import UIKit

final class ToiletsPersistingValue {
    private let entityName = "Toilets"

    func save(toilets: ResultApiDTO) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let storedToiletsEntity = NSEntityDescription.entity(forEntityName: entityName,
                                                                    in: managedContext) else { return }

        for toiletInfo in toilets.records {
            let toiletsData = NSManagedObject(entity: storedToiletsEntity, insertInto: managedContext)
            toiletsData.setValue(toiletInfo.fields.adress, forKeyPath: "adress")
            toiletsData.setValue(toiletInfo.fields.district, forKeyPath: "district")
            toiletsData.setValue(toiletInfo.fields.accessPrm, forKeyPath: "accessPrm")
            toiletsData.setValue(toiletInfo.fields.coordinates[0], forKeyPath: "lat")
            toiletsData.setValue(toiletInfo.fields.coordinates[1], forKeyPath: "lon")
            toiletsData.setValue(toiletInfo.fields.schedule, forKeyPath: "schedule")
            toiletsData.setValue(toilets.numberOfItem, forKeyPath: "numberOfItem")
        }
        do {
            try managedContext.save()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }

    func clean() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(deleteRequest)
        } catch let error {
            print("Could not remove. \(error.localizedDescription)")
        }
    }

    func getToiletsData() -> ResultApiDTO? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        let toiletsData = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var toilets: [ToiletsDTO] = []
        var numberOfItem = 0
        
        do {
            let toiletsContext = try managedContext.fetch(toiletsData)
            let toiletsInfo = toiletsContext.compactMap({ $0 as? Toilets })
            
            for toilet in toiletsInfo.map({ info in
                numberOfItem = Int(info.numberOfItem)
                let field = FieldsDTO(schedule: info.schedule,
                                      coordinates: [info.lat, info.lon],
                                      adress: info.adress,
                                      district: Int(info.district),
                                      accessPrm: info.accessPrm)
                return ToiletsDTO(field: field)
            }) {
                toilets.append(toilet)
            }
        } catch let error {
            print("Could not fetch. \(error.localizedDescription)")
            return nil
        }
        return ResultApiDTO(numberOfItem: numberOfItem, records: toilets)
    }
}
