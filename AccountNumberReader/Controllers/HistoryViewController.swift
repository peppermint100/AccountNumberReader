//
//  HistoryViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: HistorySearchResultsViewController())
        vc.searchBar.placeholder = "제목, 스캔내용으로 검색"
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
        searchController.searchBar.text = "123"
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}

// MARK: SearchBarExtensions
extension HistoryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}
