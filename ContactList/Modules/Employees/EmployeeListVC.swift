//
//  EmployeesVC.swift
//  ContactList
//
//  Created by Julian Builes on 1/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class EmployeeListVC: UIViewController {

    // MARK: - Properties
    private var bag = DisposeBag()
    var employeeVM: EmployeeVM!
    
    // MARK: - IBOUtlets
    @IBOutlet weak var employeesTV: UITableView!
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var noResultsLbl: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModelBinding()
        employeeVM.fetchEmployeeData()
        self.title = "Employees"
    }

    // MARK: - Rx Model bindings
    private func configureViewModelBinding() {
        cellForRowBinding(vm: employeeVM)
        cellWasSelectedBinding(tv: employeesTV)
    }
    
    private func cellForRowBinding(vm: EmployeeVM) {
        vm.employeesPublisher.observe(on: MainScheduler.instance)
        .do(onNext: { [weak self] employees in
            // Show 'no result view' only when request returns no results
            self?.hideNoResultsView(hide: employees.count > 1)
        }, onError:{ [weak self] error in
            self?.hideNoResultsView(hide: false)
            self?.present(AlertFactory.genericErrorAlert(), animated: true, completion: nil)
        }).catchAndReturn([Employee]())
        .bind(to:
            employeesTV.rx.items(cellIdentifier: EmployeeCell.identifier(), cellType: EmployeeCell.self)
        ) { row, employee, cell in
            cell.employee = employee
        }.disposed(by: bag)
    }
    
    private func hideNoResultsView(hide: Bool) {
        noResultsView.isHidden = hide
        employeesTV.isHidden = !hide
    }
    
    private func cellWasSelectedBinding(tv: UITableView) {
        tv.rx.modelSelected(Employee.self).subscribe { [weak self] empl in
            self?.employeeVM.displayDetailsFor(employee: empl)
        }.disposed(by: bag)
    }
}
