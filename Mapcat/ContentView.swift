//
//  ContentView.swift
//  Mapcat
//
//  Created by frh alshaalan on 13/05/2023.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreMotion

struct ContentView: View {
    @StateObject  var locationManagerWrapper = LocationManagerWrapper()
    @State  var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @State  var motionManager = CMMotionActivityManager()
    @State  var isDriving = false
    @State  var annotations: [MKPointAnnotation] = []
    @State  var trackingMode: MKUserTrackingMode = .none
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $currentLocation, annotations: annotations, trackingMode: $trackingMode)
                .onAppear {
                    locationManagerWrapper.authorize()
                    
                    if CMMotionActivityManager.isActivityAvailable() {
                        let queue = OperationQueue()
                        motionManager.startActivityUpdates(to: queue) { activity in
                            DispatchQueue.main.async {
                                isDriving = activity?.automotive ?? false
                                if isDriving {
                                    // add a pin on the map
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = currentLocation
                                    annotations.append(annotation)
                                }
                            }
                        }
                    }
                }.ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newAnnotation = MKPointAnnotation()
                        newAnnotation.coordinate = currentLocation
                        annotations.append(newAnnotation)
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.purple)
                            .padding()
                    })
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding()
                }
            }
        }
        .environmentObject(locationManagerWrapper)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



