//
//  DocumentsModel.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import Foundation
import UIKit

class DocumentsModel: ObservableObject {
    @Published var documents: [Document] = []
    @Published var navigateToScanHistory = false
    private let scanner = DocumentScanner()
    
    init() {
        self.documents = []
        addExampleDocuments()
    }
    
    func addDocument(_ document: Document) {
        documents.append(document)
        navigateToScanHistory = true
        print("document added, description:\(document.description)")
    }
    
    func deleteDocument(_document: Document) {
       // documents.remove(document)
    }
    
    /// Adding example documents
    private func addExampleDocuments() {
         let example1 = Document(
             image: UIImage(systemName: "doc.text")!,
             date: Date().addingTimeInterval(-3600),
             description: "Document 1"
         )
         let example2 = Document(
             image: UIImage(systemName: "doc.richtext")!,
             date: Date().addingTimeInterval(-86400),
             description: "Document 2"
         )
         let example3 = Document(
             image: UIImage(systemName: "doc.on.doc")!,
             date: Date().addingTimeInterval(-604800),
             description: "Document 3"
         )
         documents.append(contentsOf: [example1, example2, example3])
     }
    
    func scanDocument(_ document: Document) {
         let image = document.image

        scanner.recognizeText(from: image) { recognizedText in
            let text = recognizedText.joined(separator: "\n")
            DispatchQueue.main.async {
                if let index = self.documents.firstIndex(where: { $0.id == document.id }) {
                    self.documents[index].updateRecognizedText(text)
                }
            }
        }
    }

}
