//
//  HomeViewController.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 24/06/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {
    // MARK: Properties
    var persons: [Person]?
    let viewModel: HomeViewModelProtocol

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Initialization
    init(viewModel: HomeViewModelProtocol = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
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

// MARK: Extension
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell,
              let persons = persons else { return UITableViewCell() }
        let person = persons[indexPath.row]
        cell.setupCell(with: person)
        return cell
    }
}
