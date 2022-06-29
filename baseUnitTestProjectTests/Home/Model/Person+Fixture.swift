//
//  Person+Fixture.swift
//  baseUnitTestProjectTests
//
//  Created by Leonardo Cunha on 29/06/22.
//

import Foundation
@testable import baseUnitTestProject

extension Person {
    static func fixture(name: String = "",
                        age: Int = 0,
                        height: Double = 0) -> Self {
        Person(name: name,
               age: age,
               height: height)
    }
}
