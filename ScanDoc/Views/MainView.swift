//
//  MainView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                Text("ScanDoc")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Button(action: {
                    // scan
                }){
                    Text("Naskenovat doklad")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.black)
            .background(Color.white)
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    MainView()
}
