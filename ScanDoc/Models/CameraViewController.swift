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
    @Published var documentsModel: DocumentsModel?
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
         configureCaptureSession()
         previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
         previewLayer.frame = view.layer.bounds
         previewLayer.videoGravity = .resizeAspectFill
         view.layer.addSublayer(previewLayer)
       
         captureSession.startRunning()
     }
    
    func configureCaptureSession() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("No video device available")
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
    
    func capturePhoto(){
        let settings = AVCapturePhotoSettings()
                photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
                      let uiImage = UIImage(data: imageData) else { return }
                print("Photo captured!")
        let doc = Document(
              image: uiImage,
              date: Date(),
              description: "Document captured"
          )
        documentsModel?.addDocument(doc)
    }
}
