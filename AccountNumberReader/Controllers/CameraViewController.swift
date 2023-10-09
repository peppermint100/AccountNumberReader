//
//  CameraViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/22.
//

import UIKit
import AVFoundation
import Vision
import VisionKit

class CameraViewController: UIViewController {
    
    var session: AVCaptureSession?
    var output = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var cameraStatus: CameraStatus = .camera
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        sv.backgroundColor = .black
        return sv
    }()
    
    private let cameraView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let featureView: UIStackView = {
        let sv = UIStackView()
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
    
    private let shutterButtonContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let shutterButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let useThisPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("사진 사용", for: .normal)
        button.setTitle("사진 사용", for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray2, for: .disabled)
        return button
    }()
    
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        view.layer.addSublayer(previewLayer)
        stackView.addArrangedSubview(cameraView)
        stackView.addArrangedSubview(featureView)
        featureView.addArrangedSubview(retryButton)
        featureView.addArrangedSubview(shutterButtonContainer)
        featureView.addArrangedSubview(useThisPhotoButton)
        shutterButtonContainer.addSubview(shutterButton)
        applyConstraints()
        checkCameraPermission()
        configureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayerSubiviews")
        super.viewDidLayoutSubviews()
        setupPreviewLayer()
        drawButtons()
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
    
    private func checkCameraPermission() {
        print("카메라 권한 확인 중...")
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                guard granted else {
                    print("카메라 권한 거절함")
                    return
                }
                print("카메라 권한 허용 확인")
                DispatchQueue.main.async { [weak self] in
                    self?.setupCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            print("카메라 권한 허용 확인")
            setupCamera()
        @unknown default:
            break
        }
    }
    
    private func setupPreviewLayer() {
        print("setupPreviewLayer - previewLayer 그리는 중")
        cameraView.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = cameraView.bounds
    }
    
    private func reloadCamera() {
        output = AVCapturePhotoOutput()
        previewLayer = AVCaptureVideoPreviewLayer()
        cameraView.image = nil
    }
    
    private func setupCamera() {
        print("setupCamera - 카메라 세팅 중...")
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
                    self.session = session
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /*
     featureView의 높이, featureView의 넓이 / 3 중 낮은 값으로 버튼 레이어의 크기를 지정.
     버튼을 featureView의 넓이 / 3안에 딱 맞춰서 radius를 지정하기 위함
     */
    private func drawButtons() {
        print("버튼 그리는 중")
        switch self.cameraStatus {
        case .camera:
            retryButton.isEnabled = false
            useThisPhotoButton.isEnabled = false
        case .captured:
            retryButton.isEnabled = true
            useThisPhotoButton.isEnabled = true
        }
        let buttonWidth = view.frame.width / 3
        let featureViewHeight = featureView.frame.height
        let stadardSize = min(buttonWidth, featureViewHeight)
        let buttonSize = stadardSize - 30
        
        shutterButton.frame = CGRect(
            x: (buttonWidth - buttonSize) / 2,
            y: (featureViewHeight - buttonSize) / 2,
            width: buttonSize, height: buttonSize)
        shutterButton.layer.cornerRadius = buttonSize / 2
        shutterButton.clipsToBounds = true
        shutterButton.layer.borderWidth = 5
        shutterButton.layer.borderColor = UIColor.white.cgColor
    }
    
    private func configureButtons() {
        shutterButton.addTarget(self, action: #selector(didTapShutterButton), for: .touchUpInside)
        retryButton.addTarget(self, action: #selector(didTapRetryButton), for: .touchUpInside)
        useThisPhotoButton.addTarget(self, action: #selector(didTapUseThisPhotoButton), for: .touchUpInside)
    }
    
    @objc private func didTapShutterButton() {
        print("shutterButton 눌림")
        output.capturePhoto(
            with: AVCapturePhotoSettings(),
            delegate: self)
        cameraStatus = .captured
    }
    
    @objc private func didTapRetryButton() {
        print("retryButton 눌림")
        cameraStatus = .camera
        reloadCamera()
        setupCamera()
    }
    
    @objc private func didTapUseThisPhotoButton() {
        print("useThisPhotoButton 눌림")
        showResultSheet()
    }
    
    private func showResultSheet() {
        let vc = CaptureResultViewController()
        let sheet = vc.sheetPresentationController
        
        guard let image = cameraView.image else {
            return
        }
        
        let recognizer = TextRecognizer(image: image)
        
        recognizer.read { [weak self] text in
            let extracted = AccountExtractor.shared.extractAccount(from: text)
            vc.account = extracted
            sheet?.detents = [.medium(), .large()]
            sheet?.prefersGrabberVisible = true
            self?.present(vc, animated: true)
        }
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print("사진 output 처리 완료")
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        
        session?.stopRunning()
        
        guard let image = UIImage(data: data) else {
            return
        }

        cameraView.image = image
    }
}
