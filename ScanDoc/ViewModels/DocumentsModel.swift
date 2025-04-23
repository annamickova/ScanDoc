//
//  DocumentsModel.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import Foundation
import UIKit
import SwiftUI

import Firebase
import FirebaseFirestore
import FirebaseStorage

class DocumentsModel: ObservableObject {
    @Published var documents: [Document] = []
    @Published var navigateToScanHistory = false
    private let scanner = DocumentScanner()
    private var db = Firestore.firestore()
    
    init() {
        fetchDocuments()
        //addExampleDocuments()
    }
    
    func addDocument(_ document: Document) {
        do {
            try db.collection("documents").document(document.id ?? UUID().uuidString).setData(from: document)
            fetchDocuments()
        } catch {
            print("Error saving document: \(error)")
        }
    }
    
    func deleteDocument(_ document: Document) {
        if let documentID = document.id{
            db.collection("documents").document(documentID).delete { error in
                if let error = error {
                    print("Error deleting document from Firestore: \(error.localizedDescription)")
                } else {
                    print("Document successfully deleted from Firestore")
                    DispatchQueue.main.async {
                        self.documents.removeAll { $0.id == documentID }
                        self.fetchDocuments()
                    }
                }
            }
        }
    }
    
    func fetchDocuments(){
        db.collection("documents").order(by: "date", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            if let docs = snapshot?.documents {
                self.documents = docs.compactMap { try? $0.data(as: Document.self) }
            }
        }
    }
    
    func scanDocument(_ document: Document) {
        guard let image = document.image else { return }
        let scanner = DocumentScanner()
        scanner.recognizeText(from: image) { text in
            DispatchQueue.main.async {
                guard let index = self.documents.firstIndex(where: { $0.id == document.id }) else { return }
                self.documents[index].recognizedText = text.joined(separator: "\n")
            
                if let updated = try? Firestore.Encoder().encode(self.documents[index]),
                   let id = document.id {
                    self.db.collection("documents").document(id).setData(updated, merge: true)
                }
            }
        }
    }
    
}
