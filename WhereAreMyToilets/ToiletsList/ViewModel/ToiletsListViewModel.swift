//
//  ToiletsListViewModel.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import Foundation

final class ToiletsListViewModel {
    var result: [ToiletsDTO] = []
    private var originalResult: [ToiletsDTO] = []
    private var useCase: GetToiletsUseCaseInterface
    
    init(useCase: GetToiletsUseCaseInterface) {
        self.useCase = useCase
    }
    
    func getToilets(start: String, handler: @escaping (() -> Void)) {
        useCase.getToilets(start: start, handler: { [weak self] value in
            guard let self = self else { return }
            self.result = value
            self.originalResult = value
            handler()
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
