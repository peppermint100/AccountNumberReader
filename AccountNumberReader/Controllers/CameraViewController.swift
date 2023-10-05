//
//  CameraViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/22.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.backgroundColor = .black
        return sv
    }()
    
    private let cameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let featureView: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .brown
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("다시 찍기", for: .normal)
        button.setTitle("다시 찍기", for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray2, for: .disabled)
        return button
    }()
    
    private let shutterButton: UIButton = {
        let button = UIButton()
        button.setTitle("다시 찍기", for: .normal)
        button.setTitle("다시 찍기", for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray2, for: .disabled)
        return button
    }()
    
    private let useThisPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("다시 찍기", for: .normal)
        button.setTitle("다시 찍기", for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray2, for: .disabled)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackView.addArrangedSubview(cameraView)
        stackView.addArrangedSubview(featureView)
        featureView.addArrangedSubview(retryButton)
        featureView.addArrangedSubview(shutterButton)
        featureView.addArrangedSubview(useThisPhotoButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        let cameraViewConstraints = [
            cameraView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8)
        ]
        
        let featureViewConstraints = [
            featureView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(cameraViewConstraints)
        NSLayoutConstraint.activate(featureViewConstraints)
    }
}
