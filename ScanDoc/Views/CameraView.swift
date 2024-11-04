//
//  CameraView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct CameraView: View {
    var camera = CameraViewModel()
    var body: some View {
        NavigationView{
            VStack{
                camera.edgesIgnoringSafeArea(.all)
                Button(action: {
                    camera.capturePhoto()
                }){
                    VStack{
                        Image(systemName: "largecircle.fill.circle")
                            .font(.system(size: 70))
                            .padding()
                        Text("Zachytit fotku")
                            .font(.headline)
                            .padding(.bottom)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    
                }
            }
        }
        
    }
}


#Preview {
    CameraView()
}
