//
//  File.swift
//  Mapcat
//
//  Created by frh alshaalan on 13/05/2023.
//

import Foundation
import SwiftUI
import MapKit
import CoreMotion

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.canShowCallout = true
        return view
    }
}

