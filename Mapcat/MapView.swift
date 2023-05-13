//
//  MapView.swift
//  Mapcat
//
//  Created by frh alshaalan on 13/05/2023.
//

import Foundation
import SwiftUI
import MapKit
import CoreMotion

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var annotations: [MKPointAnnotation]
    @Binding var trackingMode: MKUserTrackingMode
    @EnvironmentObject var locationManagerWrapper: LocationManagerWrapper
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        view.setUserTrackingMode(trackingMode, animated: true)
        updateAnnotations(from: view)
    }
    
    func updateAnnotations(from view: MKMapView) {
        view.removeAnnotations(view.annotations)
        view.addAnnotations(annotations)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
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
}
