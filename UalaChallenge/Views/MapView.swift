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
    
    var body: some View {
        VStack {
            Map {
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
