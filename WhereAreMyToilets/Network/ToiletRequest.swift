//
//  ToiletRequest.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import Foundation

import Foundation

enum ToiletRequestError: Error {
    case unknown
    case invalidUrl
}

protocol ToiletRequestInterface {
    func getToilet(start: String, handler: @escaping (Result<ResultApiDTO?, Error>) -> Void)
}

final class ToiletRequest: ToiletRequestInterface {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    private func request(_ endPoint: ToiletEndpoint, then handler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = endPoint.url else {
            return handler(.failure(ToiletRequestError.invalidUrl))
        }

        let task = urlSession.dataTask(with: url) { data, _, error in
            let result = data.map { Result.success($0) } ?? Result.failure(ToiletRequestError.unknown as Error)
            handler(result)
        }
        task.resume()
    }

    private func resultDecoder<Object: Decodable>(_ result: Result<Data, Error>, handler: @escaping (Result<Object?, Error>) -> Void) {
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            let object = try? decoder.decode(Object.self, from: data)
            handler(.success(object))
        case .failure(let error):
            handler(.failure(error))
        }
    }

    func getToilet(start: String, handler: @escaping (Result<ResultApiDTO?, Error>) -> Void) {
        let endpoint = ToiletEndpoint.toiletsLocation(start: start)
        request(endpoint, then: { [weak self] result in
            self?.resultDecoder(result, handler: handler)
        })
    }
}
