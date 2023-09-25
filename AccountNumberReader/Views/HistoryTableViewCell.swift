//
//  HistorySearchResultsTableViewCell.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/29.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    var viewModel: HistoryTableViewCellViewModel?
    var indexPath: IndexPath?
    
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
    
    let pinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
        var buttonImage = UIImage(systemName: "pin.fill", withConfiguration: imageConfiguration)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .secondaryLabel
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
        stackView.addArrangedSubview(pinButton)
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
            scannedImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.32)
        ]
        let historyDetailsViewConstraints = [
            historyDetailsView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.52)
        ]
        let pinButtonConstraints = [
            pinButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.16)
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
        NSLayoutConstraint.activate(pinButtonConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(scannedTextLabelConstraints)
        NSLayoutConstraint.activate(createdAtLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func drawPin(isPinned: Bool) {
        if (isPinned) {
            pinButton.alpha = 1
        } else {
            pinButton.alpha = 0
        }
    }
    
    func updateUI(viewModel: HistoryTableViewCellViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.drawPin(isPinned: viewModel.isPinned.value)
        }
    }
    
    func configure(with viewModel: HistoryTableViewCellViewModel) {
        titleLabel.text = viewModel.title.value
        scannedTextLabel.text = viewModel.content.value
        scannedImageView.image = viewModel.image
        createdAtLabel.text = viewModel.createdAt.toString()
        drawPin(isPinned: viewModel.isPinned.value)
    }
}
