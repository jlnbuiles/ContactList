//
//  UIViewController+Extensions.swift
//  ContactList
//
//  Created by Julian Builes on 1/14/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func instantiateFromSB() -> Self? {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        guard let vc = sb.instantiateViewController(withIdentifier: "\(Self.self)") as? Self else {
            print("Unable to instantiate \(Self.self) from storyboard.")
            // TODO: throw fatal error here?
            return nil
        }
        return vc
    }
}
