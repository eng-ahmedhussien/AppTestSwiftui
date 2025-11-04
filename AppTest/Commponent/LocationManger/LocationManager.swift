//
//  LocationManager.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 23/04/2025.
//

import Foundation
import CoreLocation
import SwiftUI

struct LocationView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack(spacing: 20) {
            
            switch locationManager.authorizationStatus {
            case .restricted:
                Text("تم تقييد الوصول إلى الموقع.")
                    .multilineTextAlignment(.center)
                    .padding()
                
            case .denied:
                VStack(spacing: 12) {
                    Text("تم رفض إذن الموقع. الرجاء تفعيله من الإعدادات.")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    LocationSettingsButton()
                }
                
            case .authorizedWhenInUse, .authorizedAlways:
                if let location = locationManager.location {
                    VStack(spacing: 10) {
                        Text("📍 خط العرض: \(location.coordinate.latitude)")
                        Text("📍 خط الطول: \(location.coordinate.longitude)")
                        
                        if !locationManager.address.isEmpty {
                            Text("🏠 العنوان: \(locationManager.address)")
                                .multilineTextAlignment(.center)
                                .padding()
                        } else {
                            Text("جاري تحديد العنوان...")
                        }
                    }
                } else {
                    Text("جاري الحصول على الموقع...")
                }
                
            case .notDetermined:
                Text("جاري طلب إذن الموقع...")
                
            @unknown default:
                Text("حدث خطأ غير متوقع.")
            }
        }
        .padding()
        .onAppear {
            locationManager.requestPermission()
        }
    }
}

struct LocationSettingsButton: View {
    var body: some View {
        Button(action: {
            if let url = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }) {
            Text("افتح الإعدادات")
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}

#Preview{
    LocationView()
}


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var address: String = ""
    @Published var location: CLLocation?
    @Published var isPermissionDenied = false
    @Published var isPermissionRestricted = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        checkAuthorization() // Call on init
    }

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }

    private func checkAuthorization() {
        authorizationStatus = manager.authorizationStatus

        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        case .restricted:
            isPermissionRestricted = true

        case .denied:
            isPermissionDenied = true

        case .authorizedWhenInUse, .authorizedAlways:
            isPermissionDenied = false
            manager.startUpdatingLocation()

        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first else { return }
        location = newLocation
        reverseGeocode(location: newLocation)
    }
    private func reverseGeocode(location: CLLocation) {
        let locale = Locale(identifier: "ar") // Arabic locale

        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { [weak self] placemarks, error in
            guard let self = self else { return }

            if let placemark = placemarks?.first {
                self.address = [
                    placemark.name,
                    placemark.locality,  // City
                    placemark.administrativeArea, // State
                    placemark.country // Country
                ]
                .compactMap { $0 }
                .joined(separator: ", ")
            } else if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                self.address = "تعذر تحديد العنوان"
            }
        }
    }

}
