//
//  DragImageView.swift
//  ImagePickerGalleryCameraSwiftUI
//
//  Created by Tariqul on 8/1/22.
//

import SwiftUI

struct DragImageView: View {
    
    //===================
    // MARK: Properties
    //===================
    @State private var currentWidth: CGFloat = 100
    @State private var addedImages = [UIImage]()
    @State private var isShowPhotoLibrary = false

    var bindingForImage: Binding<UIImage> {
        Binding<UIImage> { () -> UIImage in
            return addedImages.last ?? UIImage()
        } set: { (newImage) in
            addedImages.append(newImage)
            print("Images: \(addedImages.count)")
        }
    }
    
    var body: some View {
        VStack(spacing: 12) {
            imageView
        }
        
        // Gets a new Image
        Button {
            self.isShowPhotoLibrary = true
        } label: {
            Text("Add Image")
                .foregroundColor(Color.yellow)
        }.sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: bindingForImage)
        }
        Spacer()
    }
    
    var imageView: some View {
        VStack() {
            ForEach(addedImages, id: \.self) { image in
                //DraggableImage(image: image)
                ZStack(alignment: .top){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                    HStack{
                        Spacer()
                        Image("remove")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                addedImages.remove(at: 0)
                            }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                    
                   
                }.frame(width: 100, height: 100, alignment: .topTrailing)
            }
        }
    }
    
    
}
