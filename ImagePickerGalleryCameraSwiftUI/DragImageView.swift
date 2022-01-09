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
    let columns = [
        GridItem(.fixed(200)),
        GridItem(.fixed(200)),
    ]
    var body: some View {
        
        VStack{
            VStack() {
                imageView
            }
            
            // Gets a new Image
            Button {
                self.isShowPhotoLibrary = true
            } label: {
                Text("Add Image")
                    .frame(width: UIScreen.main.bounds.size.width/2-10, height: UIScreen.main.bounds.size.width/2-10)
                                .font(.system(size: 18))
                                .padding()
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.gray, lineWidth: 2))
            }.sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: bindingForImage)
            }
            Spacer()
        } .frame(width: UIScreen.main.bounds.size.width-100)
    }
    
    
    
    var imageView: some View {
        VStack() {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(addedImages, id: \.self) { image in
                    ZStack(alignment: .top){
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: (UIScreen.main.bounds.size.width/2)-50)
                        HStack{
                            Spacer()
                            Image("remove")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    addedImages.remove(at: 0)
                                }
                        }.frame(maxWidth: (UIScreen.main.bounds.size.width/2)-50, alignment: .trailing)
                    } .frame(width: (UIScreen.main.bounds.size.width/2)-60)
                    
                }
            }
            
        }
    }
    
    
}
