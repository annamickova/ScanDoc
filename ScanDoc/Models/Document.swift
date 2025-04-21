//
//  Document.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct Document: Identifiable{
    let id = UUID()
    var image: UIImage
    var date: Date
    var description: String
    var recognizedText: String?

      init(image: UIImage, date: Date, description: String) {
          self.image = image
          self.date = date
          self.description = description
          self.recognizedText = nil
      }
      
    mutating func updateRecognizedText(_ text: String) {
        self.recognizedText = text
      }
}
