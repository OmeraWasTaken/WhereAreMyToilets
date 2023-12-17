//
//  ToiletsListViewModel.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import Combine

final class ToiletsListViewModel {
    var maxNumberOfToilets: Int = 0
    var result: [ToiletsDTO] = []
    var originalResult: [ToiletsDTO] = []
    let request: ToiletRequestInterface
    
    init(request: ToiletRequestInterface = ToiletRequest()) {
        self.request = request
    }
    
    func getToilets(start: String, handler: @escaping (() -> Void)) {
        if Int(start) ?? 0 > maxNumberOfToilets { return }
        request.getToilet(start: start, handler: { result in
            switch result {
            case let .success(value):
                self.maxNumberOfToilets = value?.numberOfItem ?? 0
                self.originalResult.append(contentsOf: value?.records ?? [])
                self.result.append(contentsOf: value?.records ?? [])
                handler()
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
