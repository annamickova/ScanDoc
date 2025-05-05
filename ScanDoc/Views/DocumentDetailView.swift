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
    @State private var showAlert = false
    @State private var isShowingMailView = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    init(document: Document, documentsModel: DocumentsModel) {
        self.document = document
        self.documentsModel = documentsModel
        documentsModel.scanDocument(document)
    }
    
    var body: some View {
        NavigationStack{
            
            
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
                        
                        Button(action: {
                            UIPasteboard.general.string = text
                            showAlert = true
                            alertTitle = "Copied!"
                            alertMessage = "Recognized text copied to clipboard."
                        }) {
                            Label("Copy Text", systemImage: "doc.on.doc")
                        }
                        .padding(.top, 5)
                    } else {
                        Text("No text recognized")
                    }
                }.padding()
                    
                
                HStack{
                    Spacer()
                    Button{
                        documentsModel.deleteDocument(document.id ?? "") { success in
                            print("Delete result:", success)
                            if success {
                                alertTitle = "Deleted!"
                                alertMessage = "Document deleted successfully."
                            } else {
                                alertTitle = "Failed!"
                                alertMessage = "Document failed to delete."
                            }
                            showAlert = true
                        }
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 35))
                            .foregroundStyle(Color.red)
                    }
                    Spacer()
                    Button {
                        isShowingMailView = true
                    } label:{
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 35))
                            .foregroundStyle(Color.blue)
                    }
                    Spacer()
                }.padding(20)
                
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .sheet(isPresented: $isShowingMailView){
            MailComposeView(selectedDocument: document)
        }
        
        .font(.system(size: 16))
        .foregroundColor(.primary)
        .background(Color(.systemBackground))
        .padding(.bottom, 80)
        
        
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
        image: UIImage(systemName: "heart")!,
        date: Date().addingTimeInterval(-604800),
        description: "Příklad dokumentu"
    ), documentsModel: DocumentsModel())
}


