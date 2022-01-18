//
//  EmployeesCoordinator.swift
//  ContactList
//
//  Created by Julian Builes on 1/13/22.
//

import Foundation
import UIKit
    
final class EmployeeCoordinator: Coordinator {
    
    // MARK: - Properties
    private(set) var childCoordinators: [Coordinator] = []
    private(set) var navigationController: UINavigationController

    // MARK: - Initiatizer
    init(navigationController: UINavigationController) { self.navigationController = navigationController }
    
    // MARK: - Navigation
    func start() {
        if let employeeListVC = EmployeeListVC.instantiateFromSB() {
            let employeeVM = EmployeeVM(repository: BaseEntityRepository())
            employeeListVC.employeeVM = employeeVM
            employeeVM.employeeCoordinator = self
            navigationController.setViewControllers([employeeListVC], animated: false)
        }
    }
    
    func displayDetailsVCFor(employee: Employee) {
        if let employeeDetailsVC = EmployeeDetailsVC.instantiateFromSB() {
            employeeDetailsVC.employee = employee
            navigationController.present(employeeDetailsVC, animated: true)
        }
    }
}
