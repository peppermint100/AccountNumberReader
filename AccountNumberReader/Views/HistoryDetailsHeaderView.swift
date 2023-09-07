//
//  HistoryDetailsHeaderView.swift
//  AccountNumberReader

import UIKit

class HistoryDetailsHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "HistoryDetailsHeaderView"
    
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(imageView)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    func configure(with viewModel: HistoryDetailsHeaderViewViewModel) {
        imageView.image = viewModel.image
    }
}
