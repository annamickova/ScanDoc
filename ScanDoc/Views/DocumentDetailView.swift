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
    
    var body: some View {
        VStack{
            Text("Detail dokumentu")
            Text("\(document.date, formatter: dateFormatter)")
        }
        VStack{
            Image(uiImage: document.image)
                .resizable()
                .scaledToFit()
                .padding()
                            
            Text(document.description)
        }
    }
}

#Preview {
    DocumentDetailView(document: Document(
        image: UIImage(systemName: "doc.on.doc")!,
        date: Date().addingTimeInterval(-604800), 
        description: "Example Document 3"
    ))
}

/// Date formatter to display
private var dateFormatter: DateFormatter {
       let formatter = DateFormatter()
       formatter.dateStyle = .medium
       formatter.timeStyle = .short
       return formatter
   }
