//
//  CameraViewModel.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI
import UIKit

struct CameraViewModel: UIViewControllerRepresentable {
    let controller = CameraViewController()
    var documentsModel: DocumentsModel
    @State var previewSize: CGSize = .zero

    init(documentsModel: DocumentsModel) {
        self.documentsModel = documentsModel
    }
    
    /// Creates and configures CameraViewController.
    /// - Parameter context: The context which the view is created.
    /// - Returns: Configured instance of CameraViewController.
    func makeUIViewController(context: Context) -> CameraViewController {
        controller.documentsModel = documentsModel
        return controller
    }
    
    /// Updates CameraViewController.
    /// - Parameters:
    ///   - uiViewController: View instance.
    ///   - context: Context information about the update.
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
    
    /// Captures photo using camera.
    /// - Parameter completion: Closure called with the captured UIImage.
    func capturePhoto(completion: @escaping (UIImage?) -> Void) {
        controller.capturePhoto(completion: completion)
        
    }
}

