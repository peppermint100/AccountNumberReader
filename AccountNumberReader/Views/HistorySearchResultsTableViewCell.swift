//
//  HistorySearchResultsTableViewCell.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/29.
//

import UIKit

class HistorySearchResultsTableViewCell: UITableViewCell {
    
    static let identifier = "HistorySearchResultsTableViewCell"
    
    let scannedImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "square.and.arrow.up.trianglebadge.exclamationmark")
        return iv
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
    
    let copyButton: UIButton = {
        let button = UIButton()
        button.setTitle("복사", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(scannedImageView)
        addSubview(titleLabel)
        addSubview(scannedTextLabel)
        addSubview(createdAtLabel)
        addSubview(copyButton)
        addSubview(editButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
