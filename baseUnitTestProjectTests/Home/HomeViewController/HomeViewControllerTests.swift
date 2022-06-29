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
    let dataSource = HomeTableViewDataSource()
    let viewModelSpy = HomeViewModelSpy()
    let dataSourceSpy = HomeTableViewDataSourceSpy()
    
    func test_whenInstantiateHomeViewController_shouldSetHomeTableViewDataSourceAsDefaultDataSource() {
        // given
        let homeDataSourceClass = object_getClassName(HomeTableViewDataSource())
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
        let sut = HomeViewController(dataSource: dataSourceSpy, viewModel: viewModelSpy)
        
        // when
        _ = sut.view
        
        // then
        XCTAssertEqual(dataSourceSpy.numberOfRowsCallCount, 1)
    }
    
    func test_whenUpdateTableViewIsCalled_dataSourceObjectShouldReceiveHomeViewControllersData() {
        // given
        let sut = HomeViewController(dataSource: dataSource, viewModel: viewModelSpy)
        let persons: [Person] = [.fixture(), .fixture(), .fixture()]
        viewModelSpy.dataToBeReturned = persons
        
        // when
        sut.persons = persons
        _ = sut.view
        
        // then
        XCTAssertEqual(persons, dataSource.persons)
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
    
    func test_tableView_whenViewModelReturnsPersonsData_numberOfRowsShouldBeEqualToControllersDataArraySize() {
        // given
        let sut = HomeViewController(dataSource: dataSource, viewModel: viewModelSpy)
        let persons: [Person] = [.fixture(), .fixture(), .fixture()]
        viewModelSpy.dataToBeReturned = persons
        
        // when
        _ = sut.view
        sut.viewDidLoad()
        
        // then
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, persons.count)
    }
    
    func test_tableView_whenDataIsNotNil_cellShouldBeAHomeTableViewCell() {
        // given
        let sut = HomeViewController(dataSource: dataSource, viewModel: viewModelSpy)
        let persons: [Person] = [.fixture(), .fixture(), .fixture()]
        viewModelSpy.dataToBeReturned = persons
        
        // when
        _ = sut.view
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.cellForRow(at: indexPath)
        
        // then
        XCTAssertEqual(cell?.reuseIdentifier, HomeTableViewCell.identifier)
    }
}
