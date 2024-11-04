//
//  DocumentsModel.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import Foundation

class DocumentsModel: ObservableObject {
    @Published var documents: [Document] = []
    @Published var shouldNavigateToScanHistory = false
    
    func addDocument(_ document: Document) {
        documents.append(document)
        shouldNavigateToScanHistory = true  
    }
}
