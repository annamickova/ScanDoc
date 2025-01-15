//
//  CameraViewController.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import AVFoundation
import SwiftUI
import UIKit

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var photoOutput = AVCapturePhotoOutput()
    var documentsModel: DocumentsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCaptureSession()
        setupPreviewLayer()
        captureSession.startRunning()
    }

    
    func configureCaptureSession() {
        captureSession = AVCaptureSession()
        
        // Configure input device (camera)
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("No video device available")
            return
        }
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                print("Could not add input")
                return
            }
        } catch {
            print("Error accessing camera input: \(error)")
            return
        }

        // Configure output device (photo capture)
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        } else {
            print("Could not add photo output")
            return
        }
    }

    // Add the camera preview to the view
    func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }

    // Capture a photo
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }

    // Handle the captured photo
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let uiImage = UIImage(data: imageData) else {
            print("Failed to process photo")
            return
        }

        print("Photo captured successfully!")
        
        // Save the captured photo into the documents model
        let newDocument = Document(
            image: uiImage,
            date: Date(),
            description: "Captured Photo"
        )
        documentsModel?.addDocument(newDocument)
    }
}
