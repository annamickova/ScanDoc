//
//  Document.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI
import FirebaseFirestore

struct Document: Identifiable, Codable {
    @DocumentID var id: String?
    var base64Image: String
    var date: Date
    var description: String
    var recognizedText: String?
    

    var image: UIImage? {
        UIImage.decodeBase64(base64Image)
    }

    init(image: UIImage, date: Date, description: String) {
        self.base64Image = image.toBase64() ?? ""
        self.date = date
        self.description = description
    }

    // Required for Firestore decoding
    init(base64Image: String, date: Date, description: String, recognizedText: String? = nil) {
        self.base64Image = base64Image
        self.date = date
        self.description = description
        self.recognizedText = recognizedText
    }
}

extension UIImage {
    
    /// Encoding document into base64
    /// - Returns: String of base64
    func toBase64() -> String? {
        guard let data = self.jpegData(compressionQuality: 0.6) else { return nil }
        return data.base64EncodedString()
    }

    
    /// Decoding image into UIImage
    /// - Parameter base64: document in base64
    /// - Returns: UIImage of document
    static func decodeBase64(_ base64: String) -> UIImage? {
        guard let data = Data(base64Encoded: base64),
              let image = UIImage(data: data) else { return nil }
        return image
    }
}

