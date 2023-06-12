//
//  UserLocationViewModel.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

/*
 This is a view model that is used to set a destination location and generates routes to the destination.
*/

class UserLocationViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate{
    private let searchCompleter = MKLocalSearchCompleter()
    @Published var selectedLocation: MapLocation?
    @Published var startTime: String?
    @Published var arrivalTime: String?
    
    var timeToReach: Double?
    var startDateTime: Date?
    var arrivalDateTime: Date?
    var userLocation: CLLocationCoordinate2D?
    
    var queryFragment: String = "" {
        didSet{
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init(){
        super.init()
        searchCompleter.delegate = self
        self.selectedLocation = MapLocation(title: "Notun Bazar", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(37.3348863), longitude: CLLocationDegrees(-122.0089878)))
    }
    
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                             to destination: CLLocationCoordinate2D,
                             completion: @escaping (MKRoute) -> Void){
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlacemark)
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("DEBUG: [MapViewRepresentable.getDestinationRoute] Failed to get directions \(error.localizedDescription)")
                return
            }
            guard let route = response?.routes.first else {
                print("DEBUG: [MapViewRepresentable.getDestinationRoute] Failed to get directions.")
                return
            }
            self.configureStartAndArrivalTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configureStartAndArrivalTimes(with expectedTravelTime: Double){
        self.timeToReach = expectedTravelTime
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        startTime = formatter.string(from: Date())
        arrivalTime = formatter.string(from: Date() + expectedTravelTime)
    }
    
    
}


