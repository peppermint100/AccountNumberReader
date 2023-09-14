//
//  HistoryDetailsFormView.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/09/14.
//

import UIKit

class HistoryDetailsFormView: UIView {
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.backgroundColor = .systemGray4
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        ])
    }
    
    func configure(with viewModel: HistoryDetailsFormViewViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
