//
//  TabBarCoordinator.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import UIKit

enum TabBarPages {
    case listing
    case map
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .listing
        case 1:
            self = .map
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .listing:
            return "Recherche"
        case .map:
            return "Carte"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .listing:
            return 0
        case .map:
            return 1
        }
    }
}

protocol TabCoordinatorProtocol: WhereAreMyToiletsCoordinatorInterface {
    var tabBarController: UITabBarController { get set }
    func selectPage(_ page: TabBarPages)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarPages?
}

class TabCoordinator: NSObject, TabCoordinatorProtocol {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        let pages: [TabBarPages] = [.listing, .map]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }
        
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPages.listing.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white        
        navigationController.viewControllers = [tabBarController]
    }
      
    private func getTabController(_ pages: TabBarPages) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        let tabBar = UITabBarItem(title:  pages.pageTitleValue(),
                                  image: nil,
                                  tag: pages.pageOrderNumber())
        navController.tabBarItem = tabBar

        switch pages {
        case .listing:
            let viewModel = ToiletsListViewModel()
            let listView = ToiletsListView(with: viewModel)
            navController.pushViewController(listView, animated: true)
        case .map:
            let view = UIViewController()
            view.view.backgroundColor = .white
            navController.pushViewController(view, animated: true)
        }
        return navController
    }
    
    func currentPage() -> TabBarPages? { TabBarPages.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPages) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPages.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
    }
}
