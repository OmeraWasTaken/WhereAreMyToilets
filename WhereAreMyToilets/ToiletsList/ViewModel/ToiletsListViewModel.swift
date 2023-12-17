//
//  ToiletsListViewModel.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import Foundation

final class ToiletsListViewModel {
    private let toiletPersisting: ToiletsPersistingValue
    private var maxNumberOfToilets: Int = 0
    private var originalResult: [ToiletsDTO] = []
    private let request: ToiletRequestInterface
    
    var result: [ToiletsDTO] = []
    
    init(request: ToiletRequestInterface = ToiletRequest(),
         toiletPersisting: ToiletsPersistingValue = ToiletsPersistingValue()) {
        self.request = request
        self.toiletPersisting = toiletPersisting
    }
    
    func getToilets(start: String, handler: @escaping (() -> Void)) {
        if Int(start) ?? 0 > maxNumberOfToilets { return }
        request.getToilet(start: start, handler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(value):
                if let value = value {
                    self.maxNumberOfToilets = value.numberOfItem
                    self.originalResult.append(contentsOf: value.records)
                    self.result.append(contentsOf: value.records)
                    DispatchQueue.main.async {
                        self.toiletPersisting.clean()
                        self.toiletPersisting.save(toilets: value)
                    }
                } else {
                    self.getPersitingToilet()
                }
                handler()
            case .failure:
                self.getPersitingToilet()
                handler()
                break
            }
        })
    }
    
    func filterForPrm(with value: String?) {
        guard let value = value else {
            result = originalResult
            return
        }
        result = originalResult.filter({ result in
            return result.fields.accessPrm == value
        })
    }
    
    private func getPersitingToilet() {
        if let toilet = toiletPersisting.getToiletsData() {
            originalResult = toilet.records
            result = toilet.records
            maxNumberOfToilets = toilet.numberOfItem
        }
    }
}
