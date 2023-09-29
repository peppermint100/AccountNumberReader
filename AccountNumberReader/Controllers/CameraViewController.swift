//
//  CameraViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/22.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.backgroundColor = .green
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let featureView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    private let cameraView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackView.addArrangedSubview(cameraView)
        stackView.addArrangedSubview(featureView)
        featureView.addSubview(shutterButton)
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        applyConstraints()
        checkCameraPermissions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer.frame = cameraView.bounds
        cameraView.layer.addSublayer(previewLayer)
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
            shutterButton.centerXAnchor.constraint(equalTo: featureView.centerXAnchor),
            shutterButton.centerYAnchor.constraint(equalTo: featureView.centerYAnchor),
            shutterButton.widthAnchor.constraint(equalToConstant: 100),
            shutterButton.heightAnchor.constraint(equalToConstant: 100),
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(cameraViewConstraints)
        NSLayoutConstraint.activate(featureViewConstraints)
        NSLayoutConstraint.activate(shutterButtonConstraints)
    }
    
    @objc private func didTapTakePhoto() {
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
    
    private func setupCamera() {
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
                
                DispatchQueue.global(qos: .background).async {
                    session.startRunning()
                }
                
                self.session = session
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        
        session?.stopRunning()
        
        let image = UIImage(data: data)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = cameraView.bounds
        cameraView.layer.addSublayer(previewLayer)
        view.addSubview(imageView)
    }
}
