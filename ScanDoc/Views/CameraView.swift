//
//  CameraView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct CameraView: View {
    @ObservedObject var documentsModel: DocumentsModel
    @State var camera: CameraViewModel
    @State private var capturedImage: UIImage? = nil
    @State private var isEditingPhoto = false
    @Binding var selectedIndex: Int
    
    init(documentsModel: DocumentsModel, selectedIndex: Binding<Int>) {
        self.documentsModel = documentsModel
        _selectedIndex = selectedIndex
        self._camera = State(initialValue: CameraViewModel(documentsModel: documentsModel))
    }
    var body: some View {
        NavigationView{
            VStack{
                camera.frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 20)
                    .clipped()
                    .padding()

                
                Button(action: {
                    camera.capturePhoto { image in
                        if let original = image {
                            let width = original.size.width
                            let height = original.size.height
                            
                            let cropRect = CGRect(x: width * 0.1, y: height * 0.2, width: width * 0.8, height: height * 0.6)

                            if let cropped = original.crop2(to: cropRect) {
                                self.capturedImage = cropped
                            } else {
                                self.capturedImage = original
                            }

                            self.isEditingPhoto = true
                        }
                    }
                }){
                    VStack{
                        Image(systemName: "largecircle.fill.circle")
                            .font(.system(size: 70))
                            .padding()
                        Text("Zachytit fotku")
                            .font(.headline)
                            .padding(.bottom)
                    }
                    
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .foregroundColor(.white)
        }
        .sheet(isPresented: $isEditingPhoto) {
                      if let image = capturedImage {
                          EditPhotoView(
                              isPresented: $isEditingPhoto,
                              image: image, onSave: { newDocument in
                                  documentsModel.addDocument(newDocument)
                              }, selectedIndex: $selectedIndex
                          )
                      }
                  }
    }
}

import UIKit

extension UIImage {
    func crop2(to rect: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage,
              let croppedCGImage = cgImage.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: croppedCGImage, scale: self.scale, orientation: self.imageOrientation)
    }
}



#Preview {
    CameraView(documentsModel: DocumentsModel(), selectedIndex: .constant(0))
}

