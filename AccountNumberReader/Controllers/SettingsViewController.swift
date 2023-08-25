//
//  SettingsViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var sections: [AppSetting] = []
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        return tv
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        configureTableView()
        configureSections()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsHeaderView.self, forHeaderFooterViewReuseIdentifier: SettingsHeaderView.identifier)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
    }
    
    private func configureSections() {
        let copyScopeSetting = AppSetting.init(
            settingKey: .copyScope,
            settingValues: [.copyScopeOnlyAccountNumber, .copyScopeIncludeBankName, .copyScopeIncludeName])
        let includeHyphenSetting = AppSetting.init(
            settingKey: .includeHyphen,
            settingValues: [.includeHyphenOn, .includeHyphenOff])
        let leaveHistorySetting = AppSetting.init(
            settingKey: .leaveHistory,
            settingValues: [.leaveHistoryEvery, .leaveHistoryAsk, .leaveHistoryNever])
        
        sections.append(copyScopeSetting)
        sections.append(includeHyphenSetting)
        sections.append(leaveHistorySetting)
    }
    
    private func didSelectOption(_ option: SettingValue) {
        switch option {
        case .copyScopeOnlyAccountNumber:
            print(option)
        case .copyScopeIncludeBankName:
            print(option)
        case .copyScopeIncludeName:
            print(option)
        case .includeHyphenOn:
            print(option)
        case .includeHyphenOff:
            print(option)
        case .leaveHistoryEvery:
            print(option)
        case .leaveHistoryAsk:
            print(option)
        case .leaveHistoryNever:
            print(option)
        }
    }
}

// MARK: - TableView 델리게이트
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let setting = sections[section]
        return setting.settingValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath)
                as? SettingsTableViewCell
        else {
            return UITableViewCell()
        }
        
        let section = sections[indexPath.section]
        let item = section.settingValues
        let option = item[indexPath.row]

        cell.configure(with: SettingsTableViewCellViewModel(title: SettingValue.getTitle(of: option), isChecked: true))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: SettingsHeaderView.identifier) as? SettingsHeaderView
        else {
            return UITableViewHeaderFooterView()
        }
        
        let setting = sections[section]
        
        switch setting.settingKey {
        case .copyScope:
            headerView.configure(with: SettingsHeaderViewViewModel(title: "계좌번호 복사 범위"))
        case .includeHyphen:
            headerView.configure(with: SettingsHeaderViewViewModel(title: "하이픈 포함"))
        case .leaveHistory:
            headerView.configure(with: SettingsHeaderViewViewModel(title: "스캔 내역"))
        }
        
        return headerView;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        let item = section.settingValues
        let option = item[indexPath.row]
        self.didSelectOption(option)
    }
}
