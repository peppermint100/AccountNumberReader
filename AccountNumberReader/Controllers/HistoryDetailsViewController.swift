import UIKit

class HistoryDetailsViewController: UIViewController {
    
    var history: History?
    var items: [HistoryDetailsTableViewCellViewModel] = []
    
    private let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        configureTableView()
        applyConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func configureUI() {
        view.addSubview(tableView)
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
        
        items.append(titleVM)
        items.append(contentVM)
        items.append(createdAtVM)
    }
    
    private func applyConstraints() {
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
        let vm = items[indexPath.row]
        cell.configure(with: vm)
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
        
        // 3번째 메뉴인 스캔시간은 변경 불가능하도록
        if (indexPath.row == 2) {
            return
        }
        
        let item = items[indexPath.row]
        let vc = HistoryDetailsEditViewController()
        vc.value = item.value
        vc.navigationItem.title = item.title
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        navigationController?.pushViewController(vc, animated: true)
    }
}
