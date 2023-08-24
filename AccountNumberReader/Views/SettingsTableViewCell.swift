//
//  SettingsTableViewCell.swift
//  AccountNumberReader
//
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    
    private var optionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 13)
        label.backgroundColor = .red
        return label
    }()
    
    private var checkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.backgroundColor = .green
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
            optionTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            optionTitleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            optionTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            optionTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
    }
    
    func configure(with viewModel: SettingsTableViewCellViewModel) {
        optionTitleLabel.text = viewModel.title
        checkButton.setImage(nil, for: .normal)
    }
}
