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
        
        HistoryManager.shared.addHistory(historySample) { [weak self] in
            print("History 저장완료 hisory: \(historySample)")
        }
        
        getHistories()
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
        
        // MARK: 개발용 임시 코드
        addHistoryTempButton.addTarget(self, action: #selector(addHistory), for: .touchUpInside)
        configureAddHistoryTempButton()
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
        cell.selectionStyle = .none
        
        
        viewModel.isPinned.subscribe { _ in
            cell.updateUI(viewModel: viewModel)
        }
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let history = histories[indexPath.row]
        let vc = HistoryDetailsViewController()
        vc.navigationItem.title = history.title
        vc.history = history
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var history = histories[indexPath.row]
        let historyViewModel = historyViewModels[indexPath.row]
        let pinAction = UIContextualAction(style: .normal, title: "고정") { (action, view, completionHandler) in
            HistoryManager.shared.togglePin(id: history.id) { newValue in
                historyViewModel.isPinned.value = newValue
            }
            completionHandler(true)
        }
        
        let pinImageConfiguration = UIImage.SymbolConfiguration(pointSize: 15)
        
        pinAction.backgroundColor = .systemOrange
        pinAction.image = UIImage(systemName: "pin.fill", withConfiguration: pinImageConfiguration)
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [pinAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = true
        return swipeConfiguration
    }
}

// MARK: SearchBarExtensions
extension HistoryViewController: UISearchResultsUpdating {
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
}
