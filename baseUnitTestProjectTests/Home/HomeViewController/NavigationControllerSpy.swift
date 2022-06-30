//
//  NavigationControllerSpy.swift
//  baseUnitTestProjectTests
//
//  Created by Leonardo Cunha on 30/06/22.
//

import UIKit

final class NavigationControllerSpy: UINavigationController {
    // MARK: Properties
    private(set) var pushedViewController: UIViewController?
    
    // MARK: Overrides
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
}
