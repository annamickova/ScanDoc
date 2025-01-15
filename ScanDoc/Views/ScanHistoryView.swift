//
//  ScanHistoryView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct ScanHistoryView: View {
    @StateObject var documentsModel = DocumentsModel()
    
 
    var body: some View {
        VStack{
            Text("Historie skenování")
                .font(.title)
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
                .padding(.top, 90)
            Spacer()
        }
     
        .background(Color.white)
        .ignoresSafeArea()
        
       
    }
}

#Preview {
    ScanHistoryView()
}
