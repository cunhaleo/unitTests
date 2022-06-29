//
//  HomeViewModel.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 29/06/22.
//

import Foundation
@testable import baseUnitTestProject

final class HomeViewModelSpy: HomeViewModelProtocol {
    // MARK: Properties
    var dataToBeReturned: [Person]?
    
    // MARK: Methods
    func getPersons(completion: @escaping (([Person]?) -> Void)) {
        completion(dataToBeReturned)
    }
}
