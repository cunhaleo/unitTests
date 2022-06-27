//
//  HomeDataSource.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 27/06/22.
//

import UIKit
@testable import baseUnitTestProject

final class HomeTableViewDataSourceSpy: NSObject, HomeTableViewDataSourceProtocol {
    // MARK: Properties
    var data: [String]?
        
    private(set) var numberOfRowsCalled: Bool = false
    private(set) var numberOfRowsCallCount: Int = 0
    
    private(set) var cellForRowAtCalled: Bool = false
    private(set) var cellForRowAtCallCount: Int = 0
    
    // MARK: Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRowsCalled = true
        numberOfRowsCallCount += 1
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellForRowAtCalled = true
        cellForRowAtCallCount += 1
        return UITableViewCell()
    }
}
