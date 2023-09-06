//
//  HistoryDetailsHeaderView.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/09/06.
//

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
        backgroundColor = .red
        addSubview(imageView)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with viewModel: HistoryDetailsHeaderViewViewModel) {
        imageView.image = viewModel.image
    }
}
