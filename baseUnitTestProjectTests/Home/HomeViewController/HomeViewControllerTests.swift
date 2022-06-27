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
    
    func test_whenHomeViewControllerLoads_tableViewShouldExist() {
        // when
        _ = sut.view
        
        // then
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_whenTableViewLoads_numberOfRowsMethodShouldBeCalledOnce() {
        // given
        let dataSourceSpy = HomeTableViewDataSourceSpy()
        let sut = HomeViewController(dataSource: dataSourceSpy)
        
        // when
        _ = sut.view
        
        // then
        XCTAssertEqual(dataSourceSpy.numberOfRowsCallCount, 1)
    }
    
    func test_givenTableViewWasLoaded_whenUpdateTableViewIsCalled_numberOfRowsMethodShouldBeCalledAgain() {
        // given
        let dataSourceSpy = HomeTableViewDataSourceSpy()
        let sut = HomeViewController(dataSource: dataSourceSpy)
        _ = sut.view
        
        // when
        sut.updateTableView()
        
        // then
        XCTAssertEqual(dataSourceSpy.numberOfRowsCallCount, 2)
    }
    
    func test_whenUpdateTableViewIsCalled_dataSourceObjectShouldReceiveHomeViewControllersData() {
        // given
        let dataSourceSpy = HomeTableViewDataSourceSpy()
        let sut = HomeViewController(dataSource: dataSourceSpy)
        let data = ["Primeiro item", "Segundo item", "Terceiro item"]
        
        // when
        _ = sut.view
        sut.data = data
        sut.updateTableView()
        
        // then
        XCTAssertEqual(data, dataSourceSpy.data)
    }
    
    func test_tableView_initialNumberOfSectionsShouldBeOne() {
        //given
        _ = sut.view
        let numberOfSections = sut.tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_tableView_numberOfSectionsShouldBeOne() {
        //given
        _ = sut.view
        let numberOfSections = sut.tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_tableView_initialNumberOfRowsShouldBeZero() {
        //given
        _ = sut.view
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func test_tableView_numberOfRowsShouldBeEqualToControllersDataSize() {
        // given
        _ = sut.view
        
        // when
        sut.data = ["0", "1", "2"]
        sut.updateTableView()
        
        // then
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(numberOfRows, 3)
    }
}
