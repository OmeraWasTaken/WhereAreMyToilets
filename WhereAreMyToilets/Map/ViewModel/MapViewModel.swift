//
//  MapViewModel.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import CoreLocation

final class MapViewModel {
    let useCase: GetToiletsUseCaseInterface
    init(useCase: GetToiletsUseCaseInterface) {
        self.useCase = useCase
    }
    
    func getCoordinates() -> [CLLocation] {
        return useCase.getCoordinates()
    }
}
