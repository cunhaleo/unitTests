//
//  HomeViewController.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 24/06/22.
//

import UIKit

protocol HomeTableViewDataSourceProtocol: UITableViewDataSource {
    var persons: [Person]? { get set }
}

class HomeViewController: UIViewController, UITableViewDelegate {
    // MARK: Properties
    var persons: [Person]?
    let homeTableViewDataSource: HomeTableViewDataSourceProtocol
    let viewModel: HomeViewModel

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Initialization
    init(dataSource: HomeTableViewDataSourceProtocol = HomeTableViewDataSource(),
         viewModel: HomeViewModel = HomeViewModel()) {
        self.homeTableViewDataSource = dataSource
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindEvents()
    }
    
    // MARK: Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = homeTableViewDataSource
        tableView.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
    
    private func bindEvents() {
        viewModel.service { persons in
            self.homeTableViewDataSource.persons = persons
            self.tableView.reloadData()
        }
    }
}

// MARK: TableViewDataSource Object
final class HomeTableViewDataSource: NSObject, HomeTableViewDataSourceProtocol {
    var persons: [Person]?
    
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
