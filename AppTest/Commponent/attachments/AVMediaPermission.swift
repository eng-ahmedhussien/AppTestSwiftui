//
//  AVMediaPermission.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2025.
//



import Foundation
import AVFoundation
import UIKit

@MainActor
struct AVMediaPermission {
    
    let popupTitle = "Permission Missing".localized()
    let buttonTitle = "Open Setting".localized()
    let cameraPermissionMessage = "Sorry, access to the camera is denied. We need to grant permission to use this feature.".localized()
    let audioAndVideoPermissionMessage = "Sorry, access to the audio and video is denied. We need to grant permission to use this feature.".localized()
    
     func getPermission(type: AVMediaType) async -> Bool {

        let status =  AVCaptureDevice.authorizationStatus(for: type)
        
        switch(status){
        case .authorized:
            return true
        case .notDetermined:
            await AVCaptureDevice.requestAccess(for: type)
            return await getPermission(type: type)
        case .denied:
            return false
        case .restricted:
            return false
            
        @unknown default:
            return false
        }
    }
    
    func openAppSetting() -> Void{
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
}
