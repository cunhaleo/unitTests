//
//  Person.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 29/06/22.
//

import Foundation

struct Person: Decodable, Equatable {
    let name: String
    let age: Int
    let height: Double
}
