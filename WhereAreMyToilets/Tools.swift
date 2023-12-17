//
//  Tools.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import Foundation

public extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }

    class var bundle: Bundle {
        return Bundle(for: self)
    }
}
