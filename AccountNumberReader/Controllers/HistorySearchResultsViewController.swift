//
//  HistorySearchResultsViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/29.
//

import UIKit

class HistorySearchResultsViewController: UIViewController {
    var histories: [History] = []
    var historyViewModels: [HistoryTableViewCellViewModel] = []
    
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
        historyViewModels = histories.map({ history in
            return HistoryTableViewCellViewModel(
            id: history.id, title: Observable(history.title), content: Observable(history.content),
            image: history.image, createdAt: history.createdAt, isPinned: Observable(history.isPinned))
        })
        
        tableView.reloadData()
    }
    
    private func removeHistory(at: IndexPath) {
        historyViewModels.remove(at: at.row)
        tableView.reloadData()
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: TableViewExtensions
extension HistorySearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyViewModels.count
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
        let vc = HistoryDetailsViewController()
        vc.navigationItem.title = history.title
        vc.history = history
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
                self?.removeHistory(at: indexPath)
            }
            completionHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, pinAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = true
        return swipeConfiguration
    }
}
