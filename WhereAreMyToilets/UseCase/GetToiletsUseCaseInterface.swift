//
//  GetToiletsUseCaseInterface.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import CoreLocation

protocol GetToiletsUseCaseInterface {
    func getToilets(start: String, handler: @escaping (([ToiletsDTO]) -> Void))
    func getCoordinates() -> [CLLocation]
}
