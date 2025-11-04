//
//  MapViewWithAnnotation.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 26/04/2025.
//


import SwiftUI
import MapKit

struct MapViewWithAnnotation: View {
    @State private var region: MKCoordinateRegion
    private var annotation: CLLocationCoordinate2D

    init(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self._region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        ))
        self.annotation = coordinate
    }

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [AnnotatedItem(coordinate: annotation)]) { item in
            MapMarker(coordinate: item.coordinate, tint: .red) // ممكن تغير اللون لو عايز
        }
        // .edgesIgnoringSafeArea(.all)
    }
}

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}


#Preview{
    MapViewWithAnnotation(latitude: 30.0444, longitude: 31.2357) // القاهرة

}
import SwiftUI
import MapKit
import CoreLocation

// Main Map View
struct NavigationMapView: UIViewRepresentable {
    @ObservedObject var viewModel: NavigationViewModel

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)

        if let route = viewModel.route {
            mapView.addOverlay(route.polyline)
            let rect = route.polyline.boundingMapRect
            mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 80, left: 40, bottom: 80, right: 40), animated: true)
        }

        if let destination = viewModel.destination {
            let annotation = MKPointAnnotation()
            annotation.coordinate = destination
            annotation.title = "وجهتك"
            mapView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: NavigationMapView

        init(_ parent: NavigationMapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .systemBlue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}

// MARK: - ViewModel
class NavigationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published var route: MKRoute?
    @Published var destination: CLLocationCoordinate2D?
    private var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func setDestination(_ destination: CLLocationCoordinate2D) {
        self.destination = destination
        calculateRouteIfPossible()
    }

    private func calculateRouteIfPossible() {
        guard let destination = destination, let userLocation = userLocation else {
            print("🚫 Waiting for user location or destination...")
            return
        }

        print("✅ Calculating route from \(userLocation) to \(destination)")

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            if let error = error {
                print("❌ Error calculating route: \(error.localizedDescription)")
                return
            }

            if let firstRoute = response?.routes.first {
                DispatchQueue.main.async {
                    print("✅ Route ready: \(firstRoute.distance/1000) km")
                    self?.route = firstRoute
                }
            } else {
                print("❌ No route found")
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.first?.coordinate {
            self.userLocation = currentLocation
            calculateRouteIfPossible()
        }
    }

    func startNavigation() {
        guard let destination = destination else { return }
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        mapItem.name = "وجهتك"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}


#Preview{
    navigMapView()
}


struct navigMapView: View {
    @StateObject var viewModel = NavigationViewModel()

    var body: some View {
        VStack {
            NavigationMapView(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
                .frame(height: 400)

            VStack(spacing: 12) {
                Button(action: {
                    // مثال الوجهة: القاهرة
                    viewModel.setDestination(CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357))
                }) {
                    Text("تحديد الوجهة ورسم الطريق")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    viewModel.startNavigation()
                }) {
                    Text("ابدأ الملاحة")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

import SwiftUI
import MapKit
import CoreLocation

struct MapWithNavigationView: View {
    @StateObject private var locationManager = NavigationLocationManager()
    @State private var region = MKCoordinateRegion()
    
    private let destinationCoordinate: CLLocationCoordinate2D

    init(destinationLatitude: Double, destinationLongitude: Double) {
        self.destinationCoordinate = CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongitude)
    }

    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: locationManager.annotations) { item in
                MapMarker(coordinate: item.coordinate, tint: item.isDestination ? .blue : .red)
            }
            .overlay(
                DrivingRouteOverlay(route: locationManager.route)
                    .edgesIgnoringSafeArea(.all)
            )
            .frame(height: 400)
            
            VStack(spacing: 12) {
                if let route = locationManager.route {
                    Text("🚗 المسافة: \(String(format: "%.2f", route.distance / 1000)) كم")
                    Text("⏰ الوقت المتوقع: \(Int(route.expectedTravelTime / 60)) دقيقة")
                } else {
                    Text("🔄 جاري حساب الطريق...")
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        locationManager.startNavigation()
                    }) {
                        Text("ابدأ الملاحة")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        locationManager.recalculateRoute()
                    }) {
                        Text("أعد الحساب")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            locationManager.setDestination(destinationCoordinate)
        }
        .onReceive(locationManager.$region) { updatedRegion in
            self.region = updatedRegion
        }
    }
}

// MARK: - Location Manager with Navigation Logic
class NavigationLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion()
    @Published var annotations: [RouteAnnotation] = []
    @Published var route: MKRoute?

    private var destination: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func setDestination(_ coordinate: CLLocationCoordinate2D) {
        destination = coordinate
        updateAnnotations()
        requestRoute()
    }
    
    func startNavigation() {
        guard let destination = destination else { return }
        
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        destinationItem.name = "وجهتك"
        
        // Use Apple Maps to open
        destinationItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
    
    func recalculateRoute() {
        requestRoute()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first?.coordinate else { return }
        location = currentLocation
        
        region = MKCoordinateRegion(
            center: currentLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        
        updateAnnotations()
        requestRoute()
    }
    
    private func updateAnnotations() {
        guard let currentLocation = location, let destination = destination else { return }
        
        annotations = [
            RouteAnnotation(coordinate: currentLocation, isDestination: false),
            RouteAnnotation(coordinate: destination, isDestination: true)
        ]
    }
    
    private func requestRoute() {
        guard let currentLocation = location, let destination = destination else { return }

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            if let error = error {
                print("Error calculating route: \(error.localizedDescription)")
                return
            }
            self?.route = response?.routes.first
        }
    }
}

// MARK: - Driving Route Overlay
struct DrivingRouteOverlay: UIViewRepresentable {
    var route: MKRoute?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)
        if let polyline = route?.polyline {
            uiView.addOverlay(polyline)
            uiView.setVisibleMapRect(polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 60, left: 60, bottom: 60, right: 60), animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .systemBlue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}

// MARK: - Route Annotation
struct RouteAnnotation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
    var isDestination: Bool
}
