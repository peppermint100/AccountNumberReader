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
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    }
    
    private func configureSections() {
        let copyScopeSetting = AppSetting.init(
            settingKey: .copyScope,
            settingValues: [CopyScope.onlyAccountNumber.rawValue, CopyScope.includeBankName.rawValue, CopyScope.includeName.rawValue])
        let includeHyphenSetting = AppSetting.init(
            settingKey: .includeHyphen,
            settingValues: [IncludeHyphen.on.rawValue, IncludeHyphen.off.rawValue])
        let leaveHistorySetting = AppSetting.init(
            settingKey: .leaveHistory,
            settingValues: [LeaveHistory.every.rawValue, LeaveHistory.ask.rawValue, LeaveHistory.never.rawValue])
        
        sections.append(copyScopeSetting)
        sections.append(includeHyphenSetting)
        sections.append(leaveHistorySetting)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let setting = sections[section]
        return setting.settingValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}
