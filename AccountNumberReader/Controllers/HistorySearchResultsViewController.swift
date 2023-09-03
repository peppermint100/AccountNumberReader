//
//  HistorySearchResultsViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/29.
//

import UIKit

class HistorySearchResultsViewController: UIViewController {
    var histories: [History] = []
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
    }
    
    func update(with results: [History]) {
        histories = results
        tableView.reloadData()
    }
}

// MARK: TableView Delegate
extension HistorySearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath)
                as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        
        let history = histories[indexPath.row]
        
        cell.configure(with: HistorySearchResultsTableViewCellViewModel(history: history))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
