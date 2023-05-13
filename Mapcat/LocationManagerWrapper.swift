//
//  File.swift
//  Mapcat
//
//  Created by frh alshaalan on 13/05/2023.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation
import CoreMotion


class LocationManagerWrapper: NSObject, ObservableObject, CLLocationManagerDelegate {
     let manager = CLLocationManager()
    @State  var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()

    override init() {
        super.init()
        manager.delegate = self
    }
    
    func authorize() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.currentLocation = location.coordinate
        }
    }
}
