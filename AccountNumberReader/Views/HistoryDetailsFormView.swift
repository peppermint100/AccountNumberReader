//
//  HistoryDetailsFormView.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/09/14.
//

import UIKit

protocol HistoryDetailsFormViewDelegate: AnyObject {
    func moveToDetailsEditViewController(historyDetailsType: HistoryDetailsType)
}

class HistoryDetailsFormView: UIView {
    
    var historyDetailsType: HistoryDetailsType?
    var delegate: HistoryDetailsFormViewDelegate?
    
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
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        applyConstraints()
        configureTapGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func configureTapGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func onTap() {
        if let historyDetailsType {
            delegate?.moveToDetailsEditViewController(historyDetailsType: historyDetailsType)
        }
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
    func configure(with viewModel: HistoryDetailsFormViewViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
