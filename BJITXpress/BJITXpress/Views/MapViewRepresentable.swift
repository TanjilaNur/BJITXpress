//
//  MapViewRepresentable.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//
import Foundation
import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable{
    let mapView = MKMapView()
    let locationManager = LocationManager.shared
    @Binding var appState: AppState
    @EnvironmentObject var locationVM: UserLocationViewModel
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.showsTraffic = false
        return mapView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("DEBUG: [MapViewRepresentable.updateUIView] Map state is \(appState)")
        switch appState {
            case .noInput:
                context.coordinator.clearMapViewAndRecenter()
                break
            case .requestReservation:
                if let coordinate = locationVM.selectedLocation?.coordinate {
                        print("DEBUG: [MapViewRepresentable.updateUIView] Destination loaction in mapviewrepresentable is \(coordinate)")
                        context.coordinator.addAndSelectAnnotation(destinationCoordinate: coordinate)
                        context.coordinator.configurePloyline(destinationCoordinate: coordinate)
                }
            default:
                break
        }
    }
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

class MapCoordinator: NSObject, MKMapViewDelegate{
    let parent: MapViewRepresentable
    var userLocationCoordinate: CLLocationCoordinate2D?
    var currentRegion: MKCoordinateRegion?
    init(parent: MapViewRepresentable){
        self.parent = parent
        super.init()
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        userLocationCoordinate = userLocation.coordinate
        currentRegion = region
        parent.mapView.setRegion(region, animated: true)
    }
    func addAndSelectAnnotation(destinationCoordinate coordinate: CLLocationCoordinate2D){
        parent.mapView.removeAnnotations(parent.mapView.annotations)
        let annonation = MKPointAnnotation()
        annonation.coordinate = coordinate
        parent.mapView.addAnnotation(annonation)
        parent.mapView.selectAnnotation(annonation, animated: true)
    }
    func configurePloyline(destinationCoordinate coordinate: CLLocationCoordinate2D){
        guard let userLocationCoordinate = userLocationCoordinate else {
            print("DEBUG: [MapViewRepresentable.configurePloyline] userLocationCoordinate is nil.")
            return
        }
        parent.locationVM.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
            self.parent.mapView.addOverlay(route.polyline)
            self.parent.appState = .polyLineAdded
            let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
            self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    // MARK: - Tells mapview to draw overlay with the selected route
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = MKPolylineRenderer(overlay: overlay)
        polyline.strokeColor = .systemBlue
        polyline.lineWidth = 6
        return polyline
    }
    func clearMapViewAndRecenter(){
        parent.mapView.removeAnnotations(parent.mapView.annotations)
        parent.mapView.removeOverlays(parent.mapView.overlays)
        if let currentRegion = currentRegion {
            parent.mapView.setRegion(currentRegion, animated: true)
        }
    }
}





