//
//  Errors.swift
//  ContactList
//
//  Created by Julian Builes on 1/12/22.
//

import Foundation

struct ContactListError: Error {
    
    enum Kind {
        case RequestError
        case NoResultsError
    }
    
    var context: String?
}
