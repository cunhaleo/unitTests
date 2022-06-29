//
//  baseUnitTestProjectTests.swift
//  baseUnitTestProjectTests
//
//  Created by Leonardo Cunha on 24/06/22.
//

import XCTest
@testable import baseUnitTestProject

final class HomeViewControllerTests: XCTestCase {
    private lazy var sut: HomeViewController = {
        let sut = HomeViewController()
        _ = sut.view
        return sut
    }()
    
    let dataSource = HomeTableViewDataSource()
    let viewModelSpy = HomeViewModelSpy()
    let dataSourceSpy = HomeTableViewDataSourceSpy()
    
    func test_initHomeViewControllerWithCoder_shouldReturnNil() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        let sut = HomeViewController(coder: archiver)
        XCTAssertNil(sut)
    }
    
    func test_whenInstantiateHomeViewController_shouldSetHomeTableViewDataSourceAsDefaultDataSource() {
        
        guard sut.homeTableViewDataSource is HomeTableViewDataSource else {
            XCTFail()
            return
        }
    }
    
    func test_homeViewController_shouldBeTableViewDelegate() {

        XCTAssertTrue(sut.tableView.delegate === sut)
    }
    
    func test_whenHomeViewControllerLoads_tableViewShouldExist() {

        XCTAssertNotNil(sut.tableView)
    }
    
    func test_whenHomeViewControllerLoads_whenViewModelReturnsData_numberOfRowsMethodShouldBeCalledOnce() {
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
    
    func test_tableView_whenDataIsNil_numberOfSectionsShouldBeOne() {

        let numberOfSections = sut.tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_tableView_whenDataIsNil_numberOfRowsShouldBeZero() {

        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func test_tableView_whenViewModelReturnsData_numberOfSectionsShouldBeOne() {
        // given
        let sut = HomeViewController(viewModel: viewModelSpy)
        let persons: [Person] = [.fixture(), .fixture(), .fixture()]
        viewModelSpy.dataToBeReturned = persons
        
        // when
        _ = sut.view
        
        // then
        let numberOfSections = sut.tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_tableView_whenViewModelReturnsData_numberOfRowsShouldBeEqualToControllersDataArraySize() {
        // given
        let sut = HomeViewController(viewModel: viewModelSpy)
        let persons: [Person] = [.fixture(), .fixture(), .fixture()]
        viewModelSpy.dataToBeReturned = persons
        
        // when
        _ = sut.view
        
        // then
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, persons.count)
    }
    
    func test_tableView_whenViewModelReturnsData_cellShouldBeAHomeTableViewCell() {
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
