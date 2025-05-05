//
//  ScanHistoryView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct ScanHistoryView: View {
    @ObservedObject var documentsModel: DocumentsModel
    @State private var selectedDocument: Document?
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Scanned Documents")
                    .font(.title)
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .padding(.top, 60)
                if documentsModel.documents.isEmpty{
                    Text("No documents")
                        .font(.title)
                }
                else {
                    List(documentsModel.documents) { document in
                        NavigationLink(destination: DocumentDetailView(document: document, documentsModel: documentsModel)) {
                            HStack {
                                Text(document.description)
                            }
                        }.padding(6)
                        .swipeActions {
                            Button(role: .destructive) {
                                documentsModel.deleteDocument(document.id ?? "") { success in
                                    print("Delete result:", success)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            Button {
                                    self.selectedDocument = document
                            } label: {
                                Label("Share", systemImage: "square.and.arrow.up")
                            }
                            .tint(.blue)
                        }
                    }.padding(.bottom, 64)
                        .padding(.horizontal, 4)
                }
            }.sheet(item: $selectedDocument) { _ in
                MailComposeView(selectedDocument: Document(base64Image: "gyjgh", date: Date(), description: "Test Doc", recognizedText: "Sample text"))
            }
            .foregroundStyle(Color.primary)
            .background(Color.init(.systemBackground))
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.onAppear(){
            documentsModel.fetchDocuments()
        }
        

        
    }
}

#Preview {
    ScanHistoryView(documentsModel: DocumentsModel())
}
