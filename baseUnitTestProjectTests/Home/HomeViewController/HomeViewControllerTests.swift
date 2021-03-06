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
    
    let viewModelSpy = HomeViewModelSpy()
    
    func test_initHomeViewControllerWithCoder_shouldReturnNil() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        let sut = HomeViewController(coder: archiver)
        XCTAssertNil(sut)
    }
    
    func test_homeViewController_shouldBeTableViewDataSource() {
        
        XCTAssertTrue(sut.tableView.dataSource === sut)
    }
    
    func test_homeViewController_shouldBeTableViewDelegate() {
        
        XCTAssertTrue(sut.tableView.delegate === sut)
    }
    
    func test_whenHomeViewControllerLoads_tableViewShouldExist() {

        XCTAssertNotNil(sut.tableView)
    }
    
    func test_tableView_whenDataIsNil_numberOfSectionsShouldBeOne_numberOfRowsShouldBeZero() {

        let numberOfSections = sut.tableView.numberOfSections
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        
        
        XCTAssertEqual(numberOfSections, 1)
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func test_tableView_whenViewModelReturnsData_numberOfSectionsShouldBeOne_numberOfRowsShouldMatchDataArraySize() {
        // given
        let sut = HomeViewController(viewModel: viewModelSpy)
        let persons: [Person] = [.fixture(), .fixture(), .fixture()]
        viewModelSpy.dataToBeReturned = persons
        
        // when
        _ = sut.view
        
        // then
        let numberOfSections = sut.tableView.numberOfSections
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(numberOfSections, 1)
        XCTAssertEqual(numberOfRows, persons.count)
    }
    
    func test_tableView_whenViewModelReturnsData_cellShouldBeAHomeTableViewCell() {
        // given
        let sut = HomeViewController(viewModel: viewModelSpy)
        let persons: [Person] = [.fixture(), .fixture(), .fixture()]
        viewModelSpy.dataToBeReturned = persons
        
        // when
        _ = sut.view
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.cellForRow(at: indexPath)
        
        XCTAssertTrue(cell is HomeTableViewCell)
        XCTAssertEqual(cell?.reuseIdentifier, "HomeTableViewCell")
    }
    
    func test_tableView_whenViewModelReturnsData_cellLabelTextShouldShowPersonInfo() {
        // given
        let sut = HomeViewController(viewModel: viewModelSpy)
        let persons: [Person] = [.fixture(name: "Leo Cunha", age: 27, height: 1.81), .fixture(), .fixture()]
        viewModelSpy.dataToBeReturned = persons
        
        // when
        _ = sut.view
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = sut.tableView.cellForRow(at: indexPath) as? HomeTableViewCell else {
            XCTFail("Could not create cell as HomeTableViewCell")
            return
        }
        
        // then
        XCTAssertEqual(cell.labelCell.text, "Name: Leo Cunha, Age: 27, Height: 1.81")
    }
    
    func test_didSelectRowAt_shouldPushADetailsViewController() {
        let sut = HomeViewController(viewModel: viewModelSpy)
        viewModelSpy.dataToBeReturned = [.fixture()]
        _ = sut.view

        let navigationSpy = NavigationControllerSpy(rootViewController: sut)
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView(sut.tableView, didSelectRowAt: indexPath)
        
        XCTAssertTrue(navigationSpy.pushedViewController is DetailsViewController)
    }
    
    func test_didSelectRowAt_pushedDetailsViewControllerShouldReceiveSelectedPerson() {
        let sut = HomeViewController(viewModel: viewModelSpy)
        viewModelSpy.dataToBeReturned = [.fixture(name: "Joao", age: 32), .fixture(), .fixture(), .fixture()]
        
        let navigationSpy = NavigationControllerSpy(rootViewController: sut)
        _ = sut.view
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView(sut.tableView, didSelectRowAt: indexPath)
        sut.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
        guard let detailsViewController = navigationSpy.pushedViewController as? DetailsViewController else {
            XCTFail("Did not push a DetailsViewController")
            return
        }
        
        let detailsPerson = detailsViewController.person
        XCTAssertEqual(detailsPerson, Person.fixture(name: "Joao", age: 32))
    }
}
