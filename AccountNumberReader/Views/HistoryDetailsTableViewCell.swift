//
//  HistoryDetailsTableViewCell.swift
//  AccountNumberReader
//
//

import UIKit


class HistoryDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryDetailsTableViewCell"
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            titleLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        ])
    }
    
    func configure(with viewModel: HistoryDetailsTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
