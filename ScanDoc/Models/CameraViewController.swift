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
    
    @Published var captureSession: AVCaptureSession!
    @Published var previewLayer: AVCaptureVideoPreviewLayer!
    @Published var photoOutput = AVCapturePhotoOutput()
    var documentsModel: DocumentsModel?
    var photoCaptureCompletion: ((UIImage?) -> Void)?
    
    
    /// Sets up the camera and starts preview
    override func viewDidLoad() {
         super.viewDidLoad()
         configureCaptureSession()
         previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
         previewLayer.frame = view.layer.bounds
         previewLayer.videoGravity = .resizeAspectFill
         view.layer.addSublayer(previewLayer)
       
         captureSession.startRunning()
     }
    
    /// Configure AVCaptureSession with default video device
    func configureCaptureSession() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("No camera device available")
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                print("Could not add input")
                return
            }
        } catch {
            print("Error accessing input: \(error)")
            return
        }
        
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        } else {
            print("Could not add photo output")
            return
        }
    }
    
    /// Starts capturing photo
    /// - Parameter completion: Acording to result of captured image - UIImage or nil
    func capturePhoto(completion: @escaping (UIImage?) -> Void) {
        self.photoCaptureCompletion = completion
        let settings = AVCapturePhotoSettings()
                photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    /// Method called when photo has been captured
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let uiImage = UIImage(data: imageData) else {
            photoCaptureCompletion?(nil)
            return
        }
                print("Photo captured!")
       
        photoCaptureCompletion?(uiImage)
    }
}
