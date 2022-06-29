//
//  HomeTableViewCell.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 24/06/22.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"

    @IBOutlet weak var labelCell: UILabel!
    
    func setupCell(with person: Person) {
        labelCell.text = "Name: \(person.name), Age: \(person.age.description), Height: \(person.height.description)"
    }
    
}
