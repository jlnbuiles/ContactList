//
//  EmployeeVM.swift
//  ContactList
//
//  Created by Julian Builes on 1/11/22.
//

import Foundation
import RxSwift
import ProgressHUD

class EmployeeVM {

    private var repository: BaseEntityRepository<EmployeeQuery>!
    var employeesPublisher = PublishSubject<[Employee]>()
    private var bag = DisposeBag()
    var employeeCoordinator: EmployeeCoordinator?
    
    init(repository: BaseEntityRepository<EmployeeQuery>) {
        self.repository = repository
    }
    
    func fetchEmployeeData() {
        ProgressHUD.show("Loading...")
        repository.GETEntityList().subscribe { [weak self] employeeQuery in
            self?.employeesPublisher.onNext(employeeQuery.employees)
            self?.employeesPublisher.onCompleted()
        } onError: { [weak self] error in
            self?.employeesPublisher.onError(error)
            ProgressHUD.dismiss()
        } onCompleted: {
            ProgressHUD.dismiss()
        }.disposed(by: bag)
    }
    
    func displayDetailsFor(employee: Employee) {
        employeeCoordinator?.displayDetailsVCFor(employee: employee)
    }
}
