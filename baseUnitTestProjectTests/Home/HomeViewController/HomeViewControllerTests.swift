//
//  baseUnitTestProjectTests.swift
//  baseUnitTestProjectTests
//
//  Created by Leonardo Cunha on 24/06/22.
//

import XCTest
@testable import baseUnitTestProject

final class HomeViewControllerTests: XCTestCase {
    let sut = HomeViewController()
    
    func test_whenInstantiateHomeViewController_shouldSetHomeTableViewDataSourceAsDefaultDataSource() {
        // given
        let homeTableDataSource = HomeTableViewDataSource()
        let homeDataSourceClass = object_getClassName(homeTableDataSource)
        let sutDataSource = sut.homeTableViewDataSource
        let sutDataSourceDefaultClass = object_getClassName(sutDataSource)
        
        // then
        XCTAssertTrue(homeDataSourceClass == sutDataSourceDefaultClass)
    }
    
    func test_homeViewController_shouldBeTableViewDelegate() {
        // when
        _ = sut.view
        
        // then
        XCTAssertTrue(sut.tableView.delegate === sut)
    }
    
    func test_whenHomeViewControllerLoads_tableViewShouldExist() {
        // when
        _ = sut.view
        
        // then
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_whenHomeViewControllerLoads_numberOfRowsMethodShouldBeCalledOnce() {
        // given
        let dataSourceSpy = HomeTableViewDataSourceSpy()
        let sut = HomeViewController(dataSource: dataSourceSpy)
        
        // when
        _ = sut.view
        
        // then
        XCTAssertEqual(dataSourceSpy.numberOfRowsCallCount, 1)
    }
    
    func test_whenUpdateTableViewIsCalled_dataSourceObjectShouldReceiveHomeViewControllersData() {
        // given
        let dataSource = HomeTableViewDataSource()
        let sut = HomeViewController(dataSource: dataSource)
        let data = ["Primeiro item", "Segundo item", "Terceiro item"]
        
        // when
        _ = sut.view
        sut.data = data
        sut.updateTableView()
        
        // then
        XCTAssertEqual(data, dataSource.data)
    }
    
    func test_tableView_numberOfSectionsShouldBeOne() {
        // given
        _ = sut.view
        let numberOfSections = sut.tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_tableView_initialNumberOfRowsShouldBeZero() {
        // given
        _ = sut.view
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func test_tableView_whenUpdateTableViewIsCalled_numberOfRowsShouldBeEqualToControllersDataSize() {
        // given
        _ = sut.view
        let data = ["0", "1", "2", "3", "4"]
        
        // when
        sut.data = data
        sut.updateTableView()
        
        // then
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, data.count)
    }
    
    func test_tableView_whenDataIsNotNil_cellShouldBeAHomeTableViewCell() {
        // given
        let data = ["Primeiro item", "Segundo item", "Terceiro item"]
        sut.data = data
        
        // when
        _ = sut.view
        sut.updateTableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.cellForRow(at: indexPath)
        
        // then
        XCTAssertEqual(cell?.reuseIdentifier, HomeTableViewCell.identifier)
    }
    
    func test_tableView_whenDataIsNotNil_fisrtCellShouldShouldReceiveFirstStringFromData() {
        // given
        let data = ["Primeiro item", "Segundo item", "Terceiro item"]
        sut.data = data
        
        // when
        _ = sut.view
        sut.updateTableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.cellForRow(at: indexPath) as? HomeTableViewCell
        
        // then
        XCTAssertEqual(cell?.labelCell?.text, data.first)
    }
    
    func test_tableView_whenDataIsNotNil_lastCellShouldReceiveLastItemFromData() {
        // given
        let data = ["Primeiro item", "Segundo item", "Terceiro item"]
        sut.data = data
        
        // when
        _ = sut.view
        sut.updateTableView()
        let indexPath = IndexPath(row: data.count-1, section: 0)
        let cell = sut.tableView.cellForRow(at: indexPath) as? HomeTableViewCell
        
        // then
        XCTAssertEqual(cell?.labelCell?.text, data.last)
    }
}
