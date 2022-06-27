//
//  baseUnitTestProjectTests.swift
//  baseUnitTestProjectTests
//
//  Created by Leonardo Cunha on 24/06/22.
//

import XCTest
@testable import baseUnitTestProject

final class baseUnitTestProjectTests: XCTestCase {
    private let dataSourceSpy = HomeTableViewDataSourceSpy()
    private lazy var sut = HomeViewController(dataSource: dataSourceSpy)
    
    func test_whenHomeViewControllerLoads_tableViewShouldExist() {
        // when
        _ = sut.view
        
        // then
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_whenCallingPopulateTableViewData_whenDataPassedIsNotNil_dataSourceObjectDataShouldBeEqualToSutData() {
        // when
        _ = sut.view
        let data = ["Primeiro item", "Segundo item", "Terceiro item", "Quarto item", "Quinto item", "Sexto item", "Setimo item"]
        sut.data = data
        sut.populateTableViewData()
        
        // then
        XCTAssertEqual(data, dataSourceSpy.data)
    }
    
}
