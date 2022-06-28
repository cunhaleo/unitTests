//
//  HomeViewController.swift
//  baseUnitTestProject
//
//  Created by Leonardo Cunha on 24/06/22.
//

import UIKit

protocol HomeTableViewDataSourceProtocol: UITableViewDataSource {
    var data: [String]? { get set }
}

class HomeViewController: UIViewController, UITableViewDelegate {
    // MARK: Properties
    var data: [String]?
    let homeTableViewDataSource: HomeTableViewDataSourceProtocol

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Initialization
    init(dataSource: HomeTableViewDataSourceProtocol = HomeTableViewDataSource()) {
        self.homeTableViewDataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        updateTableView()
    }
    
    // MARK: Methods
    func setupTableView() {
        tableView.delegate = self // MARK: testar
        tableView.dataSource = homeTableViewDataSource
        tableView.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
    
    func updateTableView() {
        homeTableViewDataSource.data = data
        tableView.reloadData()
    }
}

// MARK: TableViewDataSource Object
final class HomeTableViewDataSource: NSObject, HomeTableViewDataSourceProtocol {
    var data: [String]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell,
              let data = data else { return UITableViewCell() }
        cell.labelCell.text = data[indexPath.row]
        return cell
    }
}
