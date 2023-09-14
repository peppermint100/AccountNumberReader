//
//  HistoryDetailsFormView.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/09/14.
//

import UIKit

class HistoryDetailsFormView: UIView {
    
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
        addSubview(titleLabel)
        addSubview(valueLabel)
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
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            valueLabel.heightAnchor.constraint(equalTo: heightAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with viewModel: HistoryDetailsFormViewViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
