//
//  Location.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 28/05/2025.
//


import SwiftUI
import MapKit



struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let imageName: String
    let description: String // Add more data as needed
}

struct MultiAnnotationMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var selectedLocationID: UUID?

    let locations: [Location] = [
        Location(coordinate: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357), title: "Cairo", imageName: "star.fill", description: "Capital of Egypt"),
        Location(coordinate: CLLocationCoordinate2D(latitude: 29.9792, longitude: 31.1342), title: "Giza", imageName: "flame.fill", description: "Famous for the Pyramids"),
        Location(coordinate: CLLocationCoordinate2D(latitude: 31.2001, longitude: 29.9187), title: "Alexandria", imageName: "leaf.fill", description: "City on the Mediterranean")
    ]

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                VStack(spacing: 4) {
                    if selectedLocationID == location.id {
                        VStack(spacing: 2) {
                            Text(location.description)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        .padding(6)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                    }
                    Image(systemName: location.imageName)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.purple)
                        .onTapGesture {
                            withAnimation {
                                selectedLocationID = location.id
                            }
                        }
                }
            }
        }
//        .frame(height: 400)
        .onTapGesture {
            // Dismiss popup when tapping elsewhere on the map
            selectedLocationID = nil
        }
    }
}

#Preview {
    MultiAnnotationMapView()
}

//MARK: ios 17+
//struct MultiAnnotationMapView: View {
//    @State private var position = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357),
//            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        )
//    )
//
//    let locations: [Location] = [
//        Location(coordinate: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357), title: "Cairo", imageName: "star.fill"),
//        Location(coordinate: CLLocationCoordinate2D(latitude: 29.9792, longitude: 31.1342), title: "Giza", imageName: "flame.fill"),
//        Location(coordinate: CLLocationCoordinate2D(latitude: 31.2001, longitude: 29.9187), title: "Alexandria", imageName: "leaf.fill")
//    ]
//
//    var body: some View {
//        Map(initialPosition: position) {
//            ForEach(locations) { location in
//                Marker(location.title, systemImage: location.imageName, coordinate: location.coordinate)
//                    .tint(.purple) // Change color here
//            }
//        }
//        .frame(height: 400)
//    }
//}



//MARK:

//
//struct Locationno: Identifiable {
//    let id = UUID()
//    let coordinate: CLLocationCoordinate2D
//    let title: String
//    let imageName: String
//}
//struct MultiAnnotationMapView1: View {
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357),
//        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    )
//
//    // Example array of coordinates
//    let locations: [Location] = [
//           Location(coordinate: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357), title: "Cairo", imageName: "star.fill"),
//           Location(coordinate: CLLocationCoordinate2D(latitude: 29.9792, longitude: 31.1342), title: "Giza", imageName: "flame.fill"),
//           Location(coordinate: CLLocationCoordinate2D(latitude: 31.2001, longitude: 29.9187), title: "Alexandria", imageName: "leaf.fill")
//       ]
//
//    var body: some View {
//        Map(coordinateRegion: $region, annotationItems: locations) { location in
//            MapMarker(coordinate: location.coordinate, tint: .red)
//        }
//        .frame(height: 400)
//    }
//}
