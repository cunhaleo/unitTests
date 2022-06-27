//
//  baseUnitTestProjectTests.swift
//  baseUnitTestProjectTests
//
//  Created by Leonardo Cunha on 24/06/22.
//

import XCTest
@testable import baseUnitTestProject

final class baseUnitTestProjectTests: XCTestCase {
    private let sut = HomeViewController()
    
    func test_tableViewShouldExist() {
        // given
        _ = sut.view
        
        // then
        XCTAssertNotNil(sut.tableView)
    }
}
