//
//  DetailsViewController.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 30/06/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private(set) var person: Person?

    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { return nil }
}
