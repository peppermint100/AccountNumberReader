//
//  CameraViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/22.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    var cameraStatus: CameraStatus = .camera
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.backgroundColor = .black
        return sv
    }()
    
    private let featureView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()

    private let cameraView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let shutterButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let shutterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다시 찍기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray2, for: .disabled)
        return button
    }()
    
    private let useThisPhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("사진 사용", for: .normal)
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
        featureView.addArrangedSubview(shutterButtonView)
        featureView.addArrangedSubview(useThisPhotoButton)
        shutterButtonView.addSubview(shutterButton)
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        retryButton.addTarget(self, action: #selector(setupCamera), for: .touchUpInside)
        useThisPhotoButton.addTarget(self, action: #selector(didTapUseThisPhotoButton), for: .touchUpInside)
        applyConstraints()
        checkCameraPermissions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer.frame = cameraView.bounds
        cameraView.layer.addSublayer(previewLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutButtons()
    }
    
    private func layoutButtons() {
        print("버튼 다시 그리는 중")
        if cameraStatus == .camera {
            useThisPhotoButton.isEnabled = false
            retryButton.isEnabled = false
        }
        else if cameraStatus == .captured {
            useThisPhotoButton.isEnabled = true
            retryButton.isEnabled = true
        }
        else {
            return
        }
    }
    
    private func applyConstraints() {
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        let cameraViewConstraints = [
            cameraView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.8)
        ]
        
        let featureViewConstraints = [
            featureView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.2)
        ]
        
        let shutterButtonConstraints = [
            shutterButton.centerXAnchor.constraint(equalTo: shutterButtonView.centerXAnchor),
            shutterButton.centerYAnchor.constraint(equalTo: shutterButtonView.centerYAnchor),
            shutterButton.widthAnchor.constraint(equalToConstant: 100),
            shutterButton.heightAnchor.constraint(equalToConstant: 100),
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(cameraViewConstraints)
        NSLayoutConstraint.activate(featureViewConstraints)
        NSLayoutConstraint.activate(shutterButtonConstraints)
    }
    
    @objc private func didTapTakePhoto() {
        print("didTapTakePhoto")
        cameraStatus = .captured
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                guard granted else {
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.setupCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setupCamera()
        @unknown default:
            break
        }
    }
    
    @objc private func setupCamera() {
        print("setupCamera")
        cameraStatus = .camera
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                DispatchQueue.global(qos: .background).async { [weak self] in
                    self?.startSession()
                }
                
                self.session = session
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func didTapUseThisPhotoButton() {
        print("usethisphoto button 탭")
    }
    
    private func startSession() {
        if let session = session {
            if !session.isRunning {
                session.startRunning()
            }
        }
    }
    
    private func stopSession() {
        if let session = session {
            if session.isRunning {
                session.stopRunning()
            }
        }
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        
        stopSession()

        let image = UIImage(data: data)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = cameraView.bounds
        cameraView.layer.addSublayer(previewLayer)
        view.addSubview(imageView)
    }
}
