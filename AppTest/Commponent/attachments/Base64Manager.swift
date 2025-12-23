//
//  Base64Manager.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2025.
//



import Foundation
import UIKit

class Base64Manager {
    static let shared: Base64Manager = Base64Manager()
    
    private init() {}
    
    func detectFileTypeFromBase64(base64String: String) -> String? {
        guard !base64String.isEmpty else { return nil }
        // Decode the Base64 string into binary data
        guard let data = Data(base64Encoded: base64String) else {
            return nil
        }
        
        // Create a buffer with the first few bytes (typically 4) for checking the file type
        var buffer = [UInt8](repeating: 0, count: 4)
        data.copyBytes(to: &buffer, count: 4)
        
        // Check the magic bytes to determine the file type
        if buffer.count >= 2 {
            switch (buffer[0], buffer[1]) {
            case (0xFF, 0xD8):
                return "JPEG"
            case (0x89, 0x50):
                return "PNG"
            case (0x47, 0x49):
                return "GIF"
            case (0x42, 0x4D):
                return "BMP"
            case (0x49, 0x49), (0x4D, 0x4D):
                return "TIFF"
            case (0x25, 0x50):
                return "PDF"
            default:
                return "Unknown"
            }
        }
        
        return "Unknown"
    }
    
    func imageToBase64(_ image: UIImage?) -> String? {
        guard let image = image else { return nil }
        if let imageData = image.pngData() {
            let base64String = imageData.base64EncodedString()
            return base64String
        }
        return nil
    }
    
    func base64ToImage(_ base64String: String) -> UIImage? {
        if let data = Data(base64Encoded: base64String) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }

    func pdfToBase64(filePath: URL) -> String? {
        do {
            let pdfData = try Data(contentsOf: filePath)
            let base64String = pdfData.base64EncodedString()
            return base64String
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func pdfDataToBase64(data: Data) -> String? {
        let pdfData = data
        let base64String = pdfData.base64EncodedString()
        return base64String
    }

    func base64ToPDF(base64String: String) -> Data? {
        if let data = Data(base64Encoded: base64String) {
            return data
        }
        return nil
    }
}
