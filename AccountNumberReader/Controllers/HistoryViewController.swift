//
//  HistoryViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var histories: [History] = []
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        return tv
    }()
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: HistorySearchResultsViewController())
        vc.searchBar.placeholder = "제목, 스캔내용으로 검색"
        return vc
    }()
    
    // MARK: 개발용 임시 코드
    let addHistoryTempButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    @objc private func addHistory() {
        let historySample = History(
            id: UUID(),
            title: "제목",
            content: "이것저것이것저것이것저것이것저것이것저것이것저것이것저것fwaefjwaklefjwalefjklawefjawejkfajew",
            image: UIImage(systemName: "square.and.arrow.up.trianglebadge.exclamationmark")!,
            createdAt: Date(),
            isPinned: false)
        
        HistoryManager.shared.addHistory(historySample) {
            print("History 저장완료 hisory: \(historySample)")
        }
    }
    
    private func configureAddHistoryTempButton() {
        view.addSubview(addHistoryTempButton)
        addHistoryTempButton.frame = CGRect(x: 200, y: 300, width: 100, height: 50)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
        configureTableView()
        getHistories()
        
        // MARK: 개발용 임시 코드
        addHistoryTempButton.addTarget(self, action: #selector(addHistory), for: .touchUpInside)
        configureAddHistoryTempButton()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func getHistories() {
        let historiesFetched = HistoryManager.shared.getHistories()
        histories = historiesFetched
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
//        tableView.register(HistorySearchResultsTableViewCell.self, forCellReuseIdentifier: HistorySearchResultsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
    }
}

// MARK: TableViewExtensions
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HistoryTableViewCell.identifier,
            for: indexPath)
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

// MARK: SearchBarExtensions
extension HistoryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}
