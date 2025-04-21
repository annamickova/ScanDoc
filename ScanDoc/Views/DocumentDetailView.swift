//
//  DocumentDetailView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 15.01.2025.
//

import SwiftUI
import UIKit

struct DocumentDetailView: View {
    let document: Document
    @ObservedObject var documentsModel: DocumentsModel
    
    init(document: Document, documentsModel: DocumentsModel) {
        self.document = document
        self.documentsModel = documentsModel
        documentsModel.scanDocument(document)
    }
    
    var body: some View {
        VStack{
            Text("Detail dokumentu")
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .padding(.top, 30)
                .padding(.bottom, 10)
            
            Text(document.description)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(5)
            
            Text("\(document.date, formatter: dateFormatter)")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(5)
        }
        VStack{
            Image(uiImage: document.image)
                .resizable()
                .frame(width: 200, height: 200)
                .padding()
        }
        Spacer()
        if let text = document.recognizedText {
            Text("Recognized Text: \(text)")
                .font(.caption)
                .foregroundColor(.gray)
        } else {
            Text("No text recognized yet")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
    /// Date formatter to display
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    DocumentDetailView(document: Document(
        image: UIImage(named: "test")!,
        date: Date().addingTimeInterval(-604800),
        description: "Příklad dokumentu"
    ), documentsModel: DocumentsModel())
}


