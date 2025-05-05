//
//  MainView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var documentsModel: DocumentsModel
    @Binding var selectedIndex: Int
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                Text("ScanDoc")
                    .font(.system(size: 45, weight: .heavy))
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1839159131, green: 0.1839159131, blue: 0.1839159131, alpha: 1)))
                    .padding(.top, 50)
                Spacer()
                NavigationLink(destination: CameraView(documentsModel: documentsModel, selectedIndex: $selectedIndex)) {
                    Text("Scan document")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.init(#colorLiteral(red: 0.1839159131, green: 0.1839159131, blue: 0.1839159131, alpha: 1)))
                        .cornerRadius(30)
                        
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.black)
            .background(Image("backgroundBlue"))
            
        }
        
        
    }
}

#Preview {
    MainView(documentsModel: DocumentsModel(), selectedIndex: .constant(0))
}
