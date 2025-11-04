//
//  Location 2.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 28/05/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 30.0, longitude: 30.0),
//        span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
//    )
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State private var selectedLocationID: UUID?

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: sampleLocations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                VStack(spacing: 5) {
                    // Show popup if this annotation is selected
                    if selectedLocationID == location.id {
                        VStack(spacing: 2) {
                            Text(location.name)
                                .font(.caption)
                                .bold()
                            Text(location.description)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        .padding(6)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                    }
                    
                    // Marker icon
                    Button {
                        if selectedLocationID == location.id {
                            selectedLocationID = nil // Toggle off
                        } else {
                            selectedLocationID = location.id // Show this popup
                        }
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LocationWithDetail: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let coordinate: CLLocationCoordinate2D
}

let sampleLocations = [
    LocationWithDetail(name: "Cairo", description: "Capital of Egypt", coordinate: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357)),
    LocationWithDetail(name: "Alexandria", description: "Mediterranean City", coordinate: CLLocationCoordinate2D(latitude: 31.2001, longitude: 29.9187))
]

#Preview {
    MapView()
}
