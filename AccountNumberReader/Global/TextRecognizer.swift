//
//  TextRecognizer.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/10/08.
//

import Foundation
import Vision
import VisionKit

class TextRecognizer {
    
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    func read(completion: @escaping ((String) -> Void)) {
        print("카메라 결과 읽는 중")
        guard let cgImage = image.cgImage else {
            fatalError()
        }
        
        let request = VNRecognizeTextRequest { request, error in
            guard let result = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                print(error?.localizedDescription)
                completion("")
                return
            }
            
            let text = result.compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: "")
            
            completion(text.replacingOccurrences(of: " ", with: ""))
        }
        
        if #available(iOS 16.0, *) {
            request.revision = VNRecognizeTextRequestRevision3
            request.recognitionLanguages = ["ko-KR"]
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        do {
            try handler.perform([request])
        } catch {
            print(error.localizedDescription)
            completion("")
        }
    }
}
