//
//  HistorySearchResultsTableViewCell.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/29.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistorySearchResultsTableViewCell"
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        return sv
    }()
    
    let scannedImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "square.and.arrow.up.trianglebadge.exclamationmark")
        return iv
    }()
    
    let historyDetailsView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        return sv
    }()
    
    let historyDetailsButton: UIButton = {
        let button = UIButton()
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let buttonImage = UIImage(
            systemName: "chevron.compact.right",
            withConfiguration: imageConfiguration)
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
       
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let scannedTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .secondaryLabel
        return label
    }()

    let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(stackView)
        stackView.addArrangedSubview(scannedImageView)
        stackView.addArrangedSubview(historyDetailsView)
        stackView.addArrangedSubview(historyDetailsButton)
        historyDetailsView.addArrangedSubview(titleLabel)
        historyDetailsView.addArrangedSubview(scannedTextLabel)
        historyDetailsView.addArrangedSubview(createdAtLabel)
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    private func applyConstraints() {
        let scannedImageViewConstraints = [
            scannedImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35)
        ]
        let historyDetailsViewConstraints = [
            historyDetailsView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.55)
        ]
        let historyDetailsButtonConstraints = [
            historyDetailsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1)
        ]
        let titleLabelConstraints = [
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        ]
        let scannedTextLabelConstraints = [
            scannedTextLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
        ]
        let createdAtLabelConstraints = [
            createdAtLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2)
        ]
        
        NSLayoutConstraint.activate(scannedImageViewConstraints)
        NSLayoutConstraint.activate(historyDetailsViewConstraints)
        NSLayoutConstraint.activate(historyDetailsButtonConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(scannedTextLabelConstraints)
        NSLayoutConstraint.activate(createdAtLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with viewModel: HistorySearchResultsTableViewCellViewModel) {
        let history = viewModel.history
        titleLabel.text = history.title
        scannedTextLabel.text = history.content
        scannedImageView.image = history.image
        createdAtLabel.text = history.createdAt.toString()
    }
}
