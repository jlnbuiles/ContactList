//
//  AppCoordinator.swift
//  ContactList
//
//  Created by Julian Builes on 1/14/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }
    func start()
}

final class AppCoordinator: Coordinator {

    // MARK: - Properties
    private(set) var childCoordinators: [Coordinator] = []
    private(set) var navigationController: UINavigationController
    private let window: UIWindow

    // MARK: - Initializer
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    // MARK: - Navigation
    func start() {
        let employeeCoordinator = EmployeeCoordinator(navigationController: navigationController)
        childCoordinators.append(employeeCoordinator)
        employeeCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
