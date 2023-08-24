//
//  SettingsTableViewCell.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/08/24.
//

import UIKit

struct SettingsTableViewCellViewModel {
    var title: String
    var isChecked: Bool
}

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    
    private var optionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private var checkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(optionTitleLabel)
        addSubview(checkButton)
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            optionTitleLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            optionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            checkButton.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func configure(with viewModel: SettingsTableViewCellViewModel) {
        optionTitleLabel.text = viewModel.title
        checkButton.setImage(nil, for: .normal)
    }
}
