//
//  PopupAttachmentPicker.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2025.
//


import SwiftUI
import MijickPopupView
import PhotosUI

struct PopupAttachmentPicker: BottomPopup {
    
    var neededCases: [FileType]
    var title: String = ""
    var selected: ((_: PickedFile)->())?
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    @State private var openCamera: Bool = false
    @State private var selectedImage: UIImage?
    @State private var openFilePicker: Bool = false
    @State private var selectedCase: Int?
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var openPhotoLibrary: Bool = false
    
    func createContent() -> some View {
        VStack {
            
            Rectangle()
                .fill(Color.gray)
                .frame(width: 40, height: 3, alignment: .center)
            
            if title != "" {
                Text(title)
                    .font(.subheadline)
            }else{
                Spacer()
                    .frame(height: 20)
            }
            Divider().padding(.bottom)
            
//            items
            
            AppButton(state: .constant(.normal)) {
                guard let index = selectedCase else { return }
                switch neededCases[index] {
                case .other(_, _, _, let closure):
                    closure()
                case .camera:
                    Task {
                        source = .camera
                        await getPermission()
                    }
                case .gallery:
                    //source = .photoLibrary
                    openPhotoLibrary = true
                case .pdf:
                    openFilePicker = true
                }
            } builder: {
                Text("Submit".localized())
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .photosPicker(isPresented: $openPhotoLibrary, selection: $photosPickerItem, matching: .images)
        .onChange(of: photosPickerItem) { _ in
            Task {
               await loadImage(photosPickerItem)
            }
        }
        .sheet(isPresented: $openCamera, onDismiss: {
            guard selectedImage != nil else {return}
            selected?(PickedFile(type: .image, image: selectedImage))
            dismiss()
        }) {
            /// image picker allows the user to choose image from library or camera
            ImagePicker(sourceType: source ,selectedImage: $selectedImage)
                .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing, content: {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.gray)
            }
            .padding(.trailing, 40)
            .padding(.top, 10)
        }).onChange(of: source) { _ in }
    }
    
    func configurePopup(popup: BottomPopupConfig) -> BottomPopupConfig {
        popup.tapOutsideToDismiss(true)
    }
    
    func getPermission() async {
        let mediaPermission = await AVMediaPermission()
        let state  = await mediaPermission.getPermission(type: .video)
        if state {
            openCamera = true
        } else {
            GenericPopupView(title: mediaPermission.popupTitle,
                             message: mediaPermission.cameraPermissionMessage,
                             onAction:  mediaPermission.openAppSetting,
                             buttonTitle: mediaPermission.buttonTitle)
            .showAndStack()
        }
    }
    
    private func loadImage(_ photosPickerItem: PhotosPickerItem?) async {
        Task {
            if let loaded = try? await photosPickerItem?.loadTransferable(type: Data.self),
               let image = UIImage(data: loaded) {
                selectedImage = image
                selected?(PickedFile(type: .image, image: selectedImage))
                dismiss()
            } else {
                debugPrint("Failed to load a valid image")
            }
        }
    }
}
extension PopupAttachmentPicker {
//    var items : some View {
//        ForEach(neededCases.indices, id: \.self) { index in
//            switch neededCases[index] {
//            case .camera:
//                //open camera
//                AppButton(state: .constant(.normal), style: .plain) {
//                    selectedCase = index
//                } builder: {
//                    HStack{
//                        Image("backgound")
//                            .overlay {
//                                Image("camera")
//                            }
//                        Text("Camera".localized())
//                        Spacer()
//                        Image(selectedCase == index ? "radioButtonOn" : "radioButtonOff")
//                            .padding(.horizontal)
//                    }
//                }
//            case .gallery:
//                //open Gallery
//                AppButton(state: .constant(.normal), style:.plain) {
//                    selectedCase = index
//                } builder: {
//                    HStack{
//                        Image("add")
//                        Text("Gallery".localized())
//                        Spacer()
//                        Image(selectedCase == index ? "radioButtonOn" : "radioButtonOff")
//                            .padding(.horizontal)
//                    }
//                }
//            case .pdf:
//                AppButton(state: .constant(.normal), style: .plain) {
//                    selectedCase = index
//                } builder: {
//                    HStack{
//                        Image("backgound")
//                            .overlay {
//                                Image(systemName:"folder")
//                            }
//                        Text("Files".localized())
//                        Spacer()
//                        
//                        Image(selectedCase == index ? "radioButtonOn" : "radioButtonOff")
//                            .padding(.horizontal)
//                    }
//                }
//                .fileImporter(isPresented: $openFilePicker,
//                              allowedContentTypes: [.pdf]) { result in
//                    switch result {
//                    case .success(let file):
//                        let gotAccess = file.startAccessingSecurityScopedResource()
//                        if !gotAccess { return }
//                        print(gotAccess)
//                        //                            guard let selectedFile = selectedFile else {return}
//                        //                            selectedFile(file)
//                        if let fileSize = try? FileManager.default.attributesOfItem(atPath: file.path)[.size] as? Int64 {
//                            let maxSizeBytes: Int64 = 5 * 1024 * 1024 // 5 MB
//                            if fileSize <= maxSizeBytes {
//                                selected?(PickedFile(type: .pdf, pdf: file))
//                                dismiss()
//                                // File size is within the limit, you can proceed
//                            } else {
//                                // File size exceeds the limit, display an alert
//                                // You can show an alert here to inform the user
//                                self.showAppMessage("File should be less than 5 MB".localized(), appearance: .toast(.error))
//                            }
//                        }
//                        
//                        //                            file.stopAccessingSecurityScopedResource()
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//                
//            case .other(let title, let image, let color, _):
//                AppButton(state: .constant(.normal), style: .plain) {
//                    selectedCase = index
//                } builder: {
//                    HStack {
//                        Image(image)
//                        Text(title)
//                            .foregroundColor(color)
//                        Spacer()
//                        
//                        Image(selectedCase == index ? "radioButtonOn" : "radioButtonOff")
//                            .padding(.horizontal)
//                    }
//                }
//            }
//        }
//    }
}
struct PopupImagePickerType_Previews: PreviewProvider {
    static var previews: some View {
        PopupAttachmentPicker(neededCases: [FileType.camera, .gallery, FileType.pdf])
            .frame(height: 200)
    }
}
