//
//  EmployeeCell.swift
//  ContactList
//
//  Created by Julian Builes on 1/11/22.
//

import Foundation
import UIKit
import AlamofireImage

class EmployeeCell: UITableViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var thumbnailIV: UIImageView!
    
    var employee: Employee? {
    didSet {
        if let employee = employee {
            emailLabel.text = employee.email
            fullNameLabel.text = employee.fullName
            typeLabel.text = employee.employeeType.humanReadableString()
            let placeholderImg = Image(named: Assets.AvatarPlaceholderImgName)
            // a placeholder in case we have a valid url but it doesn't return a photo
            // we can specify a `cacheKey` to uniquely identify the image. Since when images change, they will also change their URL, this is the easiest way to refresh stale resources.
            if let url = URL(string: employee.photoURLSM) {
                thumbnailIV.af.setImage(withURL: url,
                                        cacheKey: employee.photoURLSM,
                                        placeholderImage: placeholderImg)
            } else {// a placeholder in case we don't have a valid URL
                thumbnailIV.image = placeholderImg
            }
        }
    }
    }
}
