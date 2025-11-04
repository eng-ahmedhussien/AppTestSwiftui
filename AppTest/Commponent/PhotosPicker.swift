//
//  PhotosPicker.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/03/2025.
//

import PhotosUI
import SwiftUI


struct PhotosPickerDemo: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?

    var body: some View {
        VStack {
            PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)

            avatarImage?
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
        }
        .onChange(of: avatarItem) {
            Task {
                if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                    avatarImage = loaded
                } else {
                    print("Failed")
                }
            }
        }
    }
}


struct PhotoPickerExample: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil

    var body: some View {
        VStack {
            if let selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }

            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    Label("Select a Photo", systemImage: "photo")
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImage = Image(uiImage: uiImage)
                    }
                }
            }
        }
        .padding()
    }
}


struct PhotosPickerDemoMulieple: View {
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0..<selectedImages.count, id: \.self) { i in
                        selectedImages[i]
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                }
            }
            .toolbar {
                PhotosPicker("Select images", selection: $selectedItems, matching: .images)
            }
            .onChange(of: selectedItems) {
                Task {
                    selectedImages.removeAll()

                    for item in selectedItems {
                        if let image = try? await item.loadTransferable(type: Image.self) {
                            selectedImages.append(image)
                        }
                    }
                }
            }
        }
    }
}

#Preview{
    PhotosPickerDemo()
    PhotoPickerExample()
}
