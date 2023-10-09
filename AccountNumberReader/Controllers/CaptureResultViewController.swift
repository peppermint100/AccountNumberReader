//
//  CaptureResultViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/10/07.
//

import UIKit

protocol CatureResultViewControllerDelegate {
    func didTapCopyButton(history: History?)
}

class CaptureResultViewController: UIViewController {
    
    var history: History?
    var delegate: CatureResultViewControllerDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "아래 계좌번보를 복사할게요."
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("복사하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(accountLabel)
        view.addSubview(copyButton)
        accountLabel.text = history?.content
        applyConstraints()
        copyButton.addTarget(self, action: #selector(didTapCopyButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    private func applyConstraints() {
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        let accountLabelConstraints = [
            accountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            accountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            accountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            accountLabel.bottomAnchor.constraint(equalTo: copyButton.topAnchor, constant: -30)
        ]
        
        let copyButtonConstraints = [
            copyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            copyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            copyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            copyButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(accountLabelConstraints)
        NSLayoutConstraint.activate(copyButtonConstraints)
    }
    
    @objc private func didTapCopyButton() {
        print("복사버튼 탭")
        UIPasteboard.general.string = history?.content
        dismiss(animated: true)
        delegate?.didTapCopyButton(history: history)
    }
}
