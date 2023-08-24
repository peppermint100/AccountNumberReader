//
//  SettingsHeaderView.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/08/24.
//

import UIKit

struct SettingsHeaderViewViewModel {
    var title: String
}

class SettingsHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "SettingsHeaderView"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
        addSubview(titleLabel)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        ])
    }
    
    func configure(with viewModel: SettingsHeaderViewViewModel) {
        titleLabel.text = viewModel.title
    }
}
