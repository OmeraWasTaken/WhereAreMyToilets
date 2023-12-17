//
//  WhereAreMyToiletsCoordinator.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 15/12/2023.
//

import Foundation
import UIKit

protocol WhereAreMyToiletsCoordinatorInterface {
    func start()
}

class WhereAreMyToiletsCoordinator: WhereAreMyToiletsCoordinatorInterface {
    let window: UIWindow
    let rootViewController: UINavigationController
    var childCoordinators: [WhereAreMyToiletsCoordinatorInterface] = []

    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()

    }

    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        let tabCoordinator = TabCoordinator.init(rootViewController)
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}
