//
//  OldHomeViewController.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 30/06/22.
//

import UIKit

final class HomeViewController_: UIViewController {
    // MARK: Properties
    var persons: [Person]?
    let viewModel = HomeViewModel()
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupTableView()
        getPersons()
    }
    
    // MARK: Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
    
    private func getPersons() {
        viewModel.getPersons { persons in
            self.persons = persons
            self.tableView.reloadData()
        }
    }
}

// MARK: Extensions
extension HomeViewController_: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier,
                                                       for: indexPath) as? HomeTableViewCell,
              let persons = persons else { return UITableViewCell() }
        cell.setupCell(with: persons[indexPath.row])
        return cell
    }
}
