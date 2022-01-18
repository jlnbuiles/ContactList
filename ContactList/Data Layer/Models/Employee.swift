//
//  Employee.swift
//  ContactList
//
//  Created by Julian Builes on 1/11/22.
//

import Foundation

protocol URLPathAware {
    static func entityListPath() -> String
    // TODO: Add GET by id funtionality when endpoint available
    // static func entityDetailsPath(id: String) -> String
}

typealias Queryable = Decodable & URLPathAware

// MARK: - Employee
struct EmployeeQuery: Queryable {
    
    let employees: [Employee]
    
    // MARK: - URLPathAware protocol (queryable) - entity URL paths
    static func entityListPath() -> String { return "/employees.json" }
    
    enum CodingKeys: String, CodingKey {
        case employees
    }
}

struct Employee: Decodable {
    
    let uuid, fullName, phoneNumber, email: String
    let biography: String?
    let photoURLSM, photoURLLG: String
    let team: String?
    let employeeType: EmployeeType

    // MARK: - Decodable
    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case email = "email_address"
        case biography
        case photoURLSM = "photo_url_small"
        case photoURLLG = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }   
}

enum  EmployeeType: String, Decodable {
    
    case FullTime = "FULL_TIME"
    case PartTime = "PART_TIME"
    case Contractor = "CONTRACTOR"
    
    func humanReadableString() -> String {
        switch self {
            case .FullTime: return "Full-Time"
            case .PartTime: return "Part-Time"
            case .Contractor: return "Contractor"
        }
    }
}
