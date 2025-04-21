//
//  ScanHistoryView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct ScanHistoryView: View {
    @ObservedObject var documentsModel: DocumentsModel
 
    var body: some View {
        NavigationView{
            VStack{
                Text("Scanned Documents")
                    .font(.title)
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.primary)
                    .padding(.top, 60)
                if documentsModel.documents.isEmpty{
                    Text("No documents")
                        .font(.title)
                        .foregroundStyle(.black)
                }
                else {
                    List(documentsModel.documents) { document in NavigationLink(destination: DocumentDetailView(document: document, documentsModel: documentsModel)) {
                        HStack {
                            Text(document.description)
                                .foregroundStyle(.primary)
                        }
                        
                    }.swipeActions(content: {
                        Button{
                            documentsModel.deleteDocument(_document: document)
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                    }).tint(.red).swipeActions(content: {
                        Button{
                            print("Share")
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                    }).tint(.blue)
                        
                    }
                }
            }
            .background(Color.init(.systemBackground))
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
       
    }
}

#Preview {
    ScanHistoryView(documentsModel: DocumentsModel())
}
