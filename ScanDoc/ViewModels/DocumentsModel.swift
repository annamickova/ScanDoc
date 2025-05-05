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

    }
    
    /// Function for adding document into Firestore database.
    func addDocument(_ document: Document) {
        do {
            let ref = db.collection("documents").document()
            var documentWithID = document
            documentWithID.id = ref.documentID

            do {
                try ref.setData(from: documentWithID)
                fetchDocuments()
            } catch {
                print("Error saving document: \(error)")
            }

        }
    }
    
    
    /// Deletes document from firestore
    /// - Parameters:
    ///   - id: Id of the document.
    ///   - completion: Closure if delete was successful.
    func deleteDocument(_ id: String, completion: @escaping (Bool) -> Void) {
       
        print("Attempting to delete document with ID: \(id)")
        
        DispatchQueue.main.async{
            self.db.collection("documents").document(id).delete { error in
                print("Inside delete closure")
                if let error = error {
                    print("Error deleting document from Firestore: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("Document successfully deleted from Firestore")
                    self.fetchDocuments()
                    DispatchQueue.main.async {
                        self.documents.removeAll { $0.id == id }
                    }
                    self.fetchDocuments()
                        completion(true)
                }
            }
        }
        
    }

        
//        print("doing something")
//        
//        let documentID = document.id!
//        
//        print(documentID)
//        db.collection("documents").document(documentID).delete { error in
//            if let error = error {
//                print("Error deleting document: \(error.localizedDescription)")
//                completion(false)
//            } else {
//                print("Document successfully deleted from Firestore")
//                DispatchQueue.main.async {
//                    self.documents.removeAll { $0.id == documentID }
//                }
//                completion(true)
//            }
//        }
    

    
    /// Loading documents from database.
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
    
    /// Function for scanning documents.
    /// - Parameter document: Document we want to scan.
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
            self.fetchDocuments()
        }
    }
    
}
