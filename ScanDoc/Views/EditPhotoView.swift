//
//  EditPhotoView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 12.03.2025.
//

import SwiftUI

struct EditPhotoView: View {
    @Binding var isPresented: Bool
    @State var image: UIImage
    @State private var title: String = ""
    
    var onSave: (Document) -> Void
    
    @State private var croppedImage: UIImage?
    @Binding var selectedIndex: Int
    
    @State private var zoomScale: CGFloat = 1.0
    @State private var imageOffset: CGSize = .zero
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    let image = UIImage(named: "yourImageName") ?? self.image
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(zoomScale)
                        .offset(x: imageOffset.width + dragOffset.width,
                                y: imageOffset.height + dragOffset.height)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    zoomScale = value
                                }
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragOffset = value.translation
                                }
                                .onEnded { value in
                                    imageOffset.width += value.translation.width
                                    imageOffset.height += value.translation.height
                                    dragOffset = .zero
                                }
                        )
                    
                    Rectangle()
                        .stroke(Color.red, lineWidth: 2)
                        .frame(width: 200, height: 200)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Button("Crop Image") {
                    let cropRect = CGRect(
                        x: (geometry.size.width - 200) / 2,
                        y: (geometry.size.height - 200) / 2,
                        width: 200,
                        height: 200
                    )
                    croppedImage = cropVisiblePart(from: image, in: geometry.size, cropRect: cropRect, zoomScale: zoomScale, imageOffset: imageOffset)
                }
                .padding()
            }
            
            
            TextField("Enter title...", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .padding()
                .foregroundColor(.red)
                
                Spacer()
                
                Button("Save") {
                    let newDocument = Document(image: croppedImage ?? image, date: Date(), description: title)
                    onSave(newDocument)
                    isPresented = false
                    selectedIndex = 1
                }
                .padding()
                .foregroundColor(.blue)
            }
            .padding()
        }
        .padding()}
    
    func cropVisiblePart(from image: UIImage, in viewSize: CGSize, cropRect: CGRect, zoomScale: CGFloat, imageOffset: CGSize) -> UIImage? {
        let imageSize = image.size
        let scale = imageSize.width / viewSize.width
        
        let scaledCropOriginX = (cropRect.origin.x - imageOffset.width) * scale / zoomScale
        let scaledCropOriginY = (cropRect.origin.y - imageOffset.height) * scale / zoomScale
        let scaledCropWidth = cropRect.size.width * scale / zoomScale
        let scaledCropHeight = cropRect.size.height * scale / zoomScale
        
        let finalCropRect = CGRect(
            x: scaledCropOriginX,
            y: scaledCropOriginY,
            width: scaledCropWidth,
            height: scaledCropHeight
        )
        
        guard let cgImage = image.cgImage?.cropping(to: finalCropRect) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
    
}

#Preview {
    @State var isPresented = true
    
    EditPhotoView(
        isPresented: .constant(isPresented),
        image: UIImage(systemName: "heart")!,
        onSave: { document in
            print("Document saved: \(document.description)")
            
        }, selectedIndex: .constant(0)
    )
}


extension UIImage {
    func crop(to rect: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage?.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
