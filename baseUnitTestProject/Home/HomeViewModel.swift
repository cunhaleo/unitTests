//
//  HomeViewModel.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 29/06/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func getPersons(completion: @escaping (([Person]?) -> Void))
}

final class HomeViewModel: HomeViewModelProtocol {
    
    func getPersons(completion: @escaping (([Person]?) -> Void)) {
        let url = URL(string: "someURLString")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
            let data = data else { return }
            
            if let persons = try? JSONDecoder().decode([Person].self, from: data) {
                completion(persons)
            }
        }
    }
}

final class HomeViewModelMock: HomeViewModelProtocol {
    
    func getPersons(completion: @escaping (([Person]?) -> Void)) {
        let data: [Person] = [Person(name: "leo", age: 27, height: 1.81), Person(name: "Marina", age: 29, height: 1.68), Person(name: "Ivana", age: 56, height: 1.72)]
        completion(data)
    }
}
