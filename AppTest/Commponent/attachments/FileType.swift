//
//  FileType.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2025.
//


import SwiftUI

typealias FileTypeClosure = () -> ()

enum FileType: Equatable {
    static func == (lhs: FileType, rhs: FileType) -> Bool {
        switch(lhs, rhs) {
        case (.camera, .camera):
            return true
        case (.gallery, .gallery):
            return true
        case (.pdf, .pdf):
            return true
        case (.other, .other):
            return true
        default:
            return false
        }
    }
    
    case camera
    case gallery
    case pdf
    case other(title: String, image: String, textColor: Color, callBack: FileTypeClosure)
}

enum PickedFileType {
    case image
    case pdf
}

struct PickedFile {
    var type: PickedFileType
    var image: UIImage?
    var pdf: URL?
    var pdfData: Data?
    
    // Get Base64 from object PickedFile
    func getBase64() -> String {
        var base64String = ""
        if self.type == .image {
            base64String = Base64Manager.shared.imageToBase64(UIImage(data: (self.image?.jpegData(compressionQuality: 0.3))!)) ?? ""
        }else{
            if let pdf = self.pdf {
                base64String = Base64Manager.shared.pdfToBase64(filePath: pdf) ?? ""
            }else if let pdfData = pdfData {
                base64String = Base64Manager.shared.pdfDataToBase64(data: pdfData) ?? ""
            }
        }
        return base64String
    }
}
