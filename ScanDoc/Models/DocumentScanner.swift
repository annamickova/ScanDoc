//
//  DocumentScanner.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 19.04.2025.
//

import UIKit
import Vision

class DocumentScanner {
    
    func recognizeText(from image: UIImage, completion: @escaping ([String]) -> Void)  {
        guard let cgImage = image.cgImage else {
            print("Failed to get CGImage from UIImage")
            completion([])
            return
        }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard error == nil else {
                print("Text recognition error: \(error!.localizedDescription)")
                completion([])
                return
            }
            
            let observations = request.results as? [VNRecognizedTextObservation] ?? []
            let recognizedStrings = observations.compactMap { observation in
                observation.topCandidates(1).first?.string
            }
            completion(recognizedStrings)
            
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                print("Failed to perform OCR: \(error.localizedDescription)")
                completion([])
            }
        }
    }
}
