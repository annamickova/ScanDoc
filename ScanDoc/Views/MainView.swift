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
                    .padding(.top, 30)
                Spacer()
                NavigationLink(destination: CameraView()) {
                    Text("Naskenovat doklad")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.black)
            .background(Color.white)
            
        }
        
    }
}

#Preview {
    MainView()
}
