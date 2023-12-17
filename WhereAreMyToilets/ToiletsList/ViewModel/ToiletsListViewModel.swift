//
//  ToiletsListViewModel.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import Combine

final class ToiletsListViewModel {
    var maxNumberOfToilets: Int?
    var result: [ToiletsDTO] = []
    var originalResult: [ToiletsDTO] = []
    let request: ToiletRequestInterface
    
    init(request: ToiletRequestInterface = ToiletRequest()) {
        self.request = request
        self.getToilets(start: "0")
    }
    
    func getToilets(start: String) {
        request.getToilet(start: start, handler: { result in
            switch result {
            case let .success(value):
                self.originalResult = value?.records ?? []
                self.result = value?.records ?? []
            case .failure:
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
}
