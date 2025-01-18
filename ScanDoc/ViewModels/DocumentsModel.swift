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
    @Published var shouldNavigateToScanHistory = false
    
    init() {
        addExampleDocuments()
    }
    
    func addDocument(_ document: Document) {
        documents.append(document)
        shouldNavigateToScanHistory = true
        print("document added, description:\(document.description)")
    }
    
    // Exaple documents
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
}
