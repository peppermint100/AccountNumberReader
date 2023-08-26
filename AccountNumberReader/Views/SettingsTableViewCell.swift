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
    
    func configure(with viewModel: SettingTableViewCellViewModel) {
        let settingElement = viewModel.settingElement
        let option = viewModel.settingValue
        switch viewModel.settingElement {
        case .copyScope(let selected):
            let settingValue = CopyScope(rawValue: option)
            checkButton.isHidden = option != selected.rawValue
            switch settingValue {
            case .onlyAccountNumber:
                optionTitleLabel.text = "계좌번호"
            case .includeBankName:
                optionTitleLabel.text = "계좌번호, 은행명"
            case .includeName:
                optionTitleLabel.text = "계좌번호, 은행명, 이름"
            default:
                optionTitleLabel.text = "-"
            }
        case .includeHyphen(let selected):
            checkButton.isHidden = option != selected.rawValue
            let settingValue = IncludeHyphen(rawValue: option)
            switch settingValue {
            case .on:
                optionTitleLabel.text = "포함"
            case .off:
                optionTitleLabel.text = "미포함"
            default:
                optionTitleLabel.text = "-"
            }
        case .leaveHistory(let selected):
            checkButton.isHidden = option != selected.rawValue
            let settingValue = LeaveHistory(rawValue: option)
            switch settingValue{
            case .every:
                optionTitleLabel.text = "매 스캔마다"
            case .ask:
                optionTitleLabel.text = "매번 물어보기"
            case .never:
                optionTitleLabel.text = "저장하지 않음"
            default:
                optionTitleLabel.text = "-"
            }
        }
    }
}
