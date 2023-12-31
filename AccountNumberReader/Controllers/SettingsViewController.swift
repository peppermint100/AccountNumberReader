//
//  SettingsViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/22.
//

import UIKit

class SettingsViewController: UIViewController {
    var sections: [SettingSection] = []
    
    var copyScopeOption: SettingElement = .copyScope(.includeBankName)
    var leaveHistoryOption: SettingElement = .leaveHistory(.every)
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        return tv
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        loadSettings()
        configureTableView()
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
    
    private func loadSettings() {
        if let copyScopeValueString = UserDefaultsManager.shared.load(SettingElement.copyScope(nil).keyName),
           let leaveHistoryValueString = UserDefaultsManager.shared.load(SettingElement.leaveHistory(nil).keyName)
        {
            copyScopeOption = .copyScope(CopyScope(rawValue: copyScopeValueString))
            leaveHistoryOption = .leaveHistory(LeaveHistory(rawValue: leaveHistoryValueString))
        }
        
        sections = []
        
        let copyScopeSetting = SettingSection(
            settingElement: copyScopeOption,
            settingValues: copyScopeOption.options)
        let leaveHistorySetting = SettingSection(
            settingElement: leaveHistoryOption,
            settingValues: leaveHistoryOption.options)
               
        sections.append(copyScopeSetting)
        sections.append(leaveHistorySetting)
    }
    
    private func updateUI() {
        loadSettings()
        tableView.reloadData()
    }
}

// MARK: - TableView 델리게이트
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let setting = sections[section]
        return setting.settingValues.count
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
        
        let section = sections[section]
        let settingElement = section.settingElement
        headerView.configure(with: SettingElementViewModel(settingElement: settingElement))
        
        return headerView;
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath)
                as? SettingsTableViewCell
        else {
            return UITableViewCell()
        }
        
        let section = sections[indexPath.section]
        let settingElement = section.settingElement
        let option = section.settingValues[indexPath.row]
        
        cell.configure(with: SettingTableViewCellViewModel(settingElement: settingElement, settingValue: option))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        let item = section.settingValues
        let option = item[indexPath.row]
        
        UserDefaultsManager.shared.save(key: section.settingElement.keyName, value: option)
        
        DispatchQueue.main.async { [weak self] in
            self?.updateUI()
        }
    }
}
