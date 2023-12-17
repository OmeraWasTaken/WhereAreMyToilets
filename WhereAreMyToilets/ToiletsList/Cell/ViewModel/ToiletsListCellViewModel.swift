//
//  ToiletsListCellViewModel.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import CoreLocation

final class ToiletsListCellViewModel {
    private let address: String?
    private let district: Int
    private let schedule: String?
    private let localisation: [Float]
    private let currentLocalisation: CLLocation?
    let accessPrm: String
    
    init(address: String?,
         district: Int,
         schedule: String?,
         accessPrm: String,
         localisation: [Float],
         currentLocalisation: CLLocation?) {
        self.address = address
        self.district = district
        self.schedule = schedule
        self.accessPrm = accessPrm
        self.localisation = localisation
        self.currentLocalisation = currentLocalisation
    }
    
    func getAddress() -> String {
        return (address ?? "") + " " + String(district)
    }
    
    func getLocalisation() -> String {
        guard let currentLocalisation = self.currentLocalisation else {
            return "Nous ne pouvons pas vous donner la distance entre vous et les toilettes sans votre localisation"
        }
        let value = CLLocation(latitude: CLLocationDegrees(localisation[0]), longitude: CLLocationDegrees(localisation[1]))
        value.distance(from: currentLocalisation)
        return String(format: "%.2f", (value.distance(from: currentLocalisation) / 1000))
    }
    
    func getSchedule() -> String {
        if let schedule = self.schedule, !schedule.isEmpty {
            return schedule
        } else {
            return "Nous n'avons pas les horaires d'ouverture pour ces toilettes."
        }
    }
}
