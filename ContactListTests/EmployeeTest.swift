//
//  EmployeeTest.swift
//  ContactListTests
//
//  Created by Julian Builes on 1/15/22.
//

import XCTest
@testable import ContactList

enum EmployeeTestConstants {
    static let ValidFile = "MockEmployees"
    static let InvalidKeysFile = "MockEmployeesInvalidKeys"
    static let InvalidFormattingFile = "MockEmployeesInvalidKeys"
    static let InvalidValuesFile = "MockEmployeesInvalidValues"
    static let InvalidQueryKeysFile = "MockEmployeesInvalidQueryKeys"
    static let NonExistingFile = "a fat little piggy"
    static let MissingOptionalAttributes = "MockEmployeesOptionalMissingAttributes"
    static let MissingRequiredAttributes = "MockEmployeesRequiredMissingAttributes"
    static let EmptyEmployees = "MockEmptyEmployees"
    static let JSON = "json"
    static let EmployeeCount = 2
}


class EmployeeTest: XCTestCase {

    private var mockValidEmployeeJSONData: Data!
    private var mockValidEmployeeQuery: EmployeeQuery!
    private var mockEmployee1: Employee!
    private var mockEmployee2: Employee!
    private var jsonDecoder: JSONDecoder!
    
    override func setUpWithError() throws {
        mockEmployee1 = Employee(uuid: "0d8fcc12-4d0c-425c-8355-390b312b909c",
                                     fullName: "Justine Mason",
                                     phoneNumber: "5553280123",
                                     email: "jmason.demo@squareup.com",
                                     biography: "Engineer on the Point of Sale team.",
                                     photoURLSM: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
                                     photoURLLG: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
                                     team: "Point of Sale",
                                     employeeType: .FullTime)
        mockEmployee2 = Employee(uuid: "a98f8a2e-c975-4ba3-8b35-01f719e7de2d",
                                     fullName: "Camille Rogers",
                                     phoneNumber: "5558531970",
                                     email: "crogers.demo@squareup.com",
                                     biography: "Designer on the web marketing team.",
                                     photoURLSM: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/small.jpg",
                                     photoURLLG: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/large.jpg",
                                     team: "Public Web & Marketing",
                                     employeeType: .PartTime)
        mockValidEmployeeQuery = EmployeeQuery(employees: [mockEmployee1, mockEmployee2])
        jsonDecoder = JSONDecoder()
        if let path = Bundle(for: Self.self).path(forResource: EmployeeTestConstants.ValidFile, ofType: EmployeeTestConstants.JSON) {
            do {
                mockValidEmployeeJSONData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch { print("Unable to read file w/ error: \(error.localizedDescription)") }
        } else { print("Unable to instantiate test files for \(Self.self)") }
    }

    override func tearDownWithError() throws {
        mockValidEmployeeJSONData = nil
        mockValidEmployeeQuery = nil
        mockEmployee1 = nil
        mockEmployee2 = nil
        jsonDecoder = nil
    }

    func testDecodeValidEmployeesNoThrows() throws {
        XCTAssertNoThrow(try jsonDecoder.decode(EmployeeQuery.self, from: mockValidEmployeeJSONData))
        let employeeQuery = try jsonDecoder.decode(EmployeeQuery.self, from: mockValidEmployeeJSONData)
        XCTAssertNotNil(employeeQuery.employees)
        XCTAssertEqual(employeeQuery.employees.count, EmployeeTestConstants.EmployeeCount)
    }
    
    func testValidEmployeeCorrectValuesWereSet() throws {
        
        let employeeQuery = try jsonDecoder.decode(EmployeeQuery.self, from: mockValidEmployeeJSONData)
        let validEmployee = employeeQuery.employees[0]
        
        XCTAssertNotNil(validEmployee.uuid)
        XCTAssertNotEqual(validEmployee.uuid, "")
        XCTAssertEqual(validEmployee.uuid, mockEmployee1.uuid)
        
        XCTAssertNotNil(validEmployee.fullName)
        XCTAssertNotEqual(validEmployee.fullName, "")
        XCTAssertEqual(validEmployee.fullName, mockEmployee1.fullName)
        
        XCTAssertNotNil(validEmployee.phoneNumber)
        XCTAssertNotEqual(validEmployee.phoneNumber, "")
        XCTAssertEqual(validEmployee.phoneNumber, mockEmployee1.phoneNumber)
        
        XCTAssertNotNil(validEmployee.email)
        XCTAssertNotEqual(validEmployee.email, "")
        XCTAssertEqual(validEmployee.email, mockEmployee1.email)
        
        XCTAssertNotNil(validEmployee.biography)
        XCTAssertNotEqual(validEmployee.biography, "")
        XCTAssertEqual(validEmployee.biography, mockEmployee1.biography)
        
        XCTAssertNotNil(validEmployee.photoURLSM)
        XCTAssertNotEqual(validEmployee.photoURLSM, "")
        XCTAssertEqual(validEmployee.photoURLSM, mockEmployee1.photoURLSM)
        
        XCTAssertNotNil(validEmployee.photoURLLG)
        XCTAssertNotEqual(validEmployee.photoURLLG, "")
        XCTAssertEqual(validEmployee.photoURLLG, mockEmployee1.photoURLLG)
        
        // make sure both photo URLs are not equal
        XCTAssertNotEqual(validEmployee.photoURLLG, validEmployee.photoURLSM)
        
        XCTAssertNotNil(validEmployee.team)
        XCTAssertNotEqual(validEmployee.team, "")
        XCTAssertEqual(validEmployee.team, mockEmployee1.team)
        
        XCTAssertNotNil(validEmployee.employeeType)
        XCTAssertEqual(validEmployee.employeeType, mockEmployee1.employeeType)
        XCTAssertEqual(validEmployee.employeeType, EmployeeType.FullTime)
    }
    
    func testDecodeInValidEmployeesData() throws {
        validateThrowsFor(invalidFileName: EmployeeTestConstants.InvalidKeysFile)
        validateThrowsFor(invalidFileName: EmployeeTestConstants.InvalidValuesFile)
        validateThrowsFor(invalidFileName: EmployeeTestConstants.InvalidFormattingFile)
        validateThrowsFor(invalidFileName: EmployeeTestConstants.InvalidQueryKeysFile)
        validateThrowsFor(invalidFileName: EmployeeTestConstants.NonExistingFile)
    }
    
    private func validateThrowsFor(invalidFileName: String) {
        if let path = Bundle(for: Self.self).path(forResource: invalidFileName,
                                                  ofType: EmployeeTestConstants.JSON) {
            do {
                let invalidKeys = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                XCTAssertThrowsError(try jsonDecoder.decode(EmployeeQuery.self, from: invalidKeys))
            } catch { print("Unable to read file w/ error: \(error.localizedDescription)") }
        }
    }
    
    private func employeeDataFor(fileName: String) -> EmployeeQuery? {
        
        if let path = Bundle(for: Self.self).path(forResource: fileName,
                                                  ofType: EmployeeTestConstants.JSON) {
            do {
                let invalidKeys = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return try jsonDecoder.decode(EmployeeQuery.self, from: invalidKeys)
            } catch { print("Unable to read file w/ error: \(error.localizedDescription)") }
        }
        return nil
    }
    
    
    func testIncompleteEmployees() throws {
        // optional attributes are missing
        XCTAssertNoThrow(employeeDataFor(fileName: EmployeeTestConstants.MissingOptionalAttributes))
        let query = employeeDataFor(fileName: EmployeeTestConstants.MissingOptionalAttributes)
        XCTAssertNotNil(query)
        XCTAssertNotNil(query?.employees)
        XCTAssertEqual(query?.employees.count, EmployeeTestConstants.EmployeeCount)
        
        // required attributes are missing
        XCTAssertNoThrow(employeeDataFor(fileName: EmployeeTestConstants.MissingRequiredAttributes))
        XCTAssertNil(employeeDataFor(fileName: EmployeeTestConstants.MissingRequiredAttributes))
    }

    func testDecodeEmptyEmployeesResponse() throws {
        XCTAssertNoThrow(employeeDataFor(fileName: EmployeeTestConstants.EmptyEmployees))
        let query = employeeDataFor(fileName: EmployeeTestConstants.EmptyEmployees)
        XCTAssertNotNil(query)
        XCTAssertNotNil(query?.employees)
        XCTAssertEqual(query?.employees.count, 0)
    }
}
