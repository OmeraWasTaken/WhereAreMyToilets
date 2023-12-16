//
//  ToiletEndpoint.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import Foundation

struct ToiletEndpoint {
    let path: String
    let queryItems: [URLQueryItem]
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "data.ratp.fr"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}

extension ToiletEndpoint {
    static func toiletsLocation(start: String) -> ToiletEndpoint {
        return ToiletEndpoint(path: "/api/records/1.0/search/",
                              queryItems: [URLQueryItem(name: "dataset", value: "sanisettesparis2011"),
                                           URLQueryItem(name: "start", value: start),
                                           URLQueryItem(name: "rows", value: "100")])
    }
}
