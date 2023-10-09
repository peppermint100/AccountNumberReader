//
//  HistoryViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var histories: [History] = []
    var historyViewModels: [HistoryTableViewCellViewModel] = []
    
    var timerForDebounce: Timer?
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        return tv
    }()
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: HistorySearchResultsViewController())
        vc.searchBar.placeholder = "제목, 스캔내용으로 검색"
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHistories()
    }
    
    private func getHistories() {
        let historiesFetched = HistoryManager.shared.getHistories()
        histories = historiesFetched
        historyViewModels = histories.map({ history in
            return HistoryTableViewCellViewModel(
            id: history.id, title: Observable(history.title), content: Observable(history.content),
            image: history.image, createdAt: history.createdAt, isPinned: Observable(history.isPinned))
        })
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.becomeFirstResponder()
        searchController.hidesNavigationBarDuringPresentation = false
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
    }
    
    private func getHistoriesWithQuery(_ query: String) -> [History] {
        return HistoryManager.shared.searchHistory(query)
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
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
        
        let viewModel = historyViewModels[indexPath.row]
        
        cell.indexPath = indexPath
        cell.selectionStyle = .none
        cell.viewModel = viewModel
        
        viewModel.isPinned.subscribe { _ in
            cell.updateUI(viewModel: viewModel)
        }
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let history = histories[indexPath.row]
        print("테이블 셀 터치 \(history)")
        let vc = HistoryDetailsViewController(history: history)
        vc.navigationItem.title = history.title
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let historyViewModel = historyViewModels[indexPath.row]
        
        let pinAction = UIContextualAction(style: .normal, title: historyViewModel.isPinned.value ? "고정해제" : "고정") { (action, view, completionHandler) in
            HistoryManager.shared.togglePin(id: historyViewModel.id) { newValue in
                historyViewModel.isPinned.value = newValue
            }
            completionHandler(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler) in
            HistoryManager.shared.deleteHistory(id: historyViewModel.id) { [weak self] in
                self?.getHistories()
            }
            completionHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, pinAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = true
        return swipeConfiguration
    }
}

// MARK: SearchBarExtensions
extension HistoryViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        timerForDebounce?.invalidate()
        timerForDebounce = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            guard let searchResultController = 
                    searchController.searchResultsController as? HistorySearchResultsViewController,
                  let query = searchController.searchBar.text,
                  !query.trimmingCharacters(in: .whitespaces).isEmpty
            else {
                return
            }
            
            let historySearched = self?.getHistoriesWithQuery(query)
            searchResultController.update(with: historySearched ?? [])
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        getHistories()
     }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getHistories()
    }
}
