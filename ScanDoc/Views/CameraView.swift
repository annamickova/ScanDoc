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
        VStack{
            camera.edgesIgnoringSafeArea(.all)
            Button(action: {
                camera.capturePhoto()
            }){
                Text("Zachytit fotku")
                    .padding()
                
            }
        }
    }
}


#Preview {
    CameraView()
}
