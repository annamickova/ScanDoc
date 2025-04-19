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
                Text("Historie skenování")
                    .font(.title)
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.black)
                    .padding(.top, 90)
                if documentsModel.documents.isEmpty{
                    Text("Žádné dokumenty")
                }
                else {
                    List(documentsModel.documents) { document in NavigationLink(destination: DocumentDetailView(document: document)) {
                        HStack {
                            Text(document.description)
                        }
                        
                    }.swipeActions(content: {
                        Button{
//                            documetsModel.deleteDocumet(_documet: <#T##Document#>)
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                    }).tint(.red).swipeActions(content: {
                        Button{
                            print("Sdílet")
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                    }).tint(.blue)
                        
                    }
                }
            }
            .background(Color.white)
            .ignoresSafeArea()
        }
       
    }
}

#Preview {
    ScanHistoryView(documentsModel: DocumentsModel())
}
