import UIKit

enum HistoryDetailsType {
    case title
    case content
    case createdAt
}

class HistoryDetailsViewController: UIViewController {
    
    var history: History?
    var items: [HistoryDetails] = []
    
    private let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func configureUI() {
        view.addSubview(tableView)
    }
    
    private func updateUI() {
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(HistoryDetailsTableViewCell.self, forCellReuseIdentifier: HistoryDetailsTableViewCell.identifier)
        tableView.register(HistoryDetailsHeaderView.self, forHeaderFooterViewReuseIdentifier: HistoryDetailsHeaderView.identifier)

        let titleVM = HistoryDetailsTableViewCellViewModel(title: "제목", value: history?.title ?? "")
        let contentVM = HistoryDetailsTableViewCellViewModel(title: "복사 내용", value: history?.content ?? "")
        let createdAtVM = HistoryDetailsTableViewCellViewModel(title: "스캔 시간", value: history?.createdAt.toString() ?? "")
                
        let titleDetails = HistoryDetails(historyDetailsType: .title, historyDetailsViewModel: titleVM)
        
        let contentDetails = HistoryDetails(historyDetailsType: .content, historyDetailsViewModel: contentVM)
        
        let createdAtDetails = HistoryDetails(historyDetailsType: .createdAt, historyDetailsViewModel: createdAtVM)
       
        items.append(titleDetails)
        items.append(contentDetails)
        items.append(createdAtDetails)
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension HistoryDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryDetailsTableViewCell.identifier, for: indexPath) as? HistoryDetailsTableViewCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.configure(with: item.historyDetailsViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HistoryDetailsHeaderView.identifier) as? HistoryDetailsHeaderView else {
            return UITableViewHeaderFooterView()
        }
        
        headerView.configure(with: HistoryDetailsHeaderViewViewModel(image: history?.image ?? nil))
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row

        let item = items[indexPath.row]
        let vc = HistoryDetailsEditViewController()
        vc.history = history
        
        switch row {
        case 0:
            vc.historyDetailsType = .title
            break
        case 1:
            vc.historyDetailsType = .content
            break
        case 2:
            return
        default:
            return
        }
        
        vc.navigationItem.title = item.historyDetailsViewModel.title
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HistoryDetailsViewController: HistoryDetailsEditViewControllerDelegate {
    func didTapEditButton(newHistory: History?, type: HistoryDetailsType?) {
        if let newHistory {
            switch type {
            case .title:
                HistoryManager.shared.updateTitle(id: newHistory.id, title: newHistory.title)
            case .content:
                HistoryManager.shared.updateContent(id: newHistory.id, content: newHistory.content)
            case .createdAt:
                return
            default:
                return
            }
        }
    }
}
