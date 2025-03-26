//
//  MapView.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 25/03/2025.
//

import MapKit
import SwiftUI

struct MapView: View {
    let citySelected: City?
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        VStack {
            Map(position: $cameraPosition) {
                if let city = citySelected {
                    Marker(city.name,
                           coordinate:
                            CLLocationCoordinate2D(
                                latitude: city.coordinate.lat,
                                longitude: city.coordinate.lon
                            )
                    )
                }
            }
            .onAppear {
                updateCameraPosition()
            }
            .onChange(of: citySelected) {
                updateCameraPosition()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func updateCameraPosition() {
        if let city = citySelected {
            let coordinate = CLLocationCoordinate2D(latitude: city.coordinate.lat, longitude: city.coordinate.lon)
            cameraPosition = .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
        }
    }
}
