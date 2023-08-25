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
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private var checkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonImage = UIImage(
            systemName: "checkmark",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(optionTitleLabel)
        contentView.addSubview(checkButton)
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            optionTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
    
    func configure(with viewModel: SettingsTableViewCellViewModel) {
        optionTitleLabel.text = viewModel.title
        checkButton.isHidden = !viewModel.isChecked
    }
}
