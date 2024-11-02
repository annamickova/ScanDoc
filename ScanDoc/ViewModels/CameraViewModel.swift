//
//  CameraViewModel.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct CameraViewModel: UIViewControllerRepresentable{
    var controller = CameraViewController()
    
    func makeUIViewController(context: Context) -> CameraViewController{
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context){}
    
    func capturePhoto(){
        controller.capturePhoto()
    }
}
