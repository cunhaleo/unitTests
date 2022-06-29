//
//  HomeViewModel.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 29/06/22.
//

import Foundation

final class HomeViewModel {
    var dataToBeReturned: [Person]?
    
    func service(completion: @escaping (([Person]?) -> Void)) {
        completion(dataToBeReturned)
    }
    
}
