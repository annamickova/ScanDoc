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
                Spacer()
                if documentsModel.documents.isEmpty{
                    Text("Žádné dokumenty")
                }
                else {
                    List(documentsModel.documents) { document in NavigationLink(destination: DocumentDetailView(document: document)) {
                        HStack {
                            Text(document.description)
                        }
                        
                    }
                        
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
    ScanHistoryView(documentsModel: DocumentsModel())
}
