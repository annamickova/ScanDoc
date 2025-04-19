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

    init(documentsModel: DocumentsModel) {
        self.documentsModel = documentsModel
    }

    func makeUIViewController(context: Context) -> CameraViewController {
        controller.documentsModel = documentsModel
        return controller
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}

    func capturePhoto(completion: @escaping (UIImage?) -> Void) {
        controller.capturePhoto(completion: completion)
        
    }
}

