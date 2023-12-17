//
//  GetToiletsUseCase.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import CoreLocation

final class GetToiletsUseCase: GetToiletsUseCaseInterface {
    private let toiletPersisting: ToiletsPersistingValue
    private var maxNumberOfToilets: Int = 0
    private let request: ToiletRequestInterface
    private var result: [ToiletsDTO] = []
    
    init(request: ToiletRequestInterface = ToiletRequest(),
         toiletPersisting: ToiletsPersistingValue = ToiletsPersistingValue()) {
        self.request = request
        self.toiletPersisting = toiletPersisting
    }
    
    func getToilets(start: String, handler: @escaping (([ToiletsDTO]) -> Void)) {
        if Int(start) ?? 0 > maxNumberOfToilets { return }
        request.getToilet(start: start, handler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(value):
                if let value = value {
                    self.maxNumberOfToilets = value.numberOfItem
                    self.result.append(contentsOf: value.records)
                    DispatchQueue.main.async {
                        self.toiletPersisting.clean()
                        self.toiletPersisting.save(toilets: value)
                    }
                } else {
                    self.getPersitingToilet()
                }
                handler(self.result)
            case .failure:
                self.getPersitingToilet()
                handler(self.result)
                break
            }
        })
    }
    
    func getCoordinates() -> [CLLocation] {
        var coordinates: [CLLocation] = []
        print(self.result)
        for toilet in self.result {
            coordinates.append(CLLocation(latitude: CLLocationDegrees(toilet.fields.coordinates[0]),
                                          longitude: CLLocationDegrees(toilet.fields.coordinates[1])))
        }
        return coordinates
    }
    
    private func getPersitingToilet() {
        if let toilet = toiletPersisting.getToiletsData() {
            result = toilet.records
            maxNumberOfToilets = toilet.numberOfItem
        }
    }
}
