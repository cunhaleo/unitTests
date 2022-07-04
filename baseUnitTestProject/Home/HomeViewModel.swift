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
