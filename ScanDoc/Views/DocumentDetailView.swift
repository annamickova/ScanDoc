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
        image: UIImage(systemName: "doc.on.doc")!,
        date: Date().addingTimeInterval(-604800), 
        description: "Příklad dokumentu"
    ))
}


