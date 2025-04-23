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
    @State private var showCopiedAlert = false
    
    init(document: Document, documentsModel: DocumentsModel) {
        self.document = document
        self.documentsModel = documentsModel
    }
    
    var body: some View {
        ScrollView{
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
                if let img = document.image {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                if let text = document.recognizedText {
                    Text("Recognized Text: \(text)")
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = text
                            }) {
                                Label("Copy Text", systemImage: "doc.on.doc")
                            }
                        }
                    
                    Button(action: {
                        UIPasteboard.general.string = text
                        showCopiedAlert = true
                    }) {
                        Label("Copy Text", systemImage: "doc.on.doc")
                    }
                    .padding(.top, 5)
                    .alert(isPresented: $showCopiedAlert) {
                        Alert(title: Text("Copied!"), message: Text("Recognized text copied to clipboard."), dismissButton: .default(Text("OK")))
                    }
                } else {
                    Text("No text recognized yet")
                }
            }
            
        }
        .font(.system(size: 16))
        .foregroundColor(.black)
        .padding(.bottom, 70)
        
        
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


