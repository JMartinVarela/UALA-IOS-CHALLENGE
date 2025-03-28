//
//  ContentView.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 24/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = CitiesViewModel()
    @State private var path = NavigationPath()
    @State private var cityInfoRequired: City?
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                // Checking whether device orientation is portrait or landscape
                if geometry.size.width > geometry.size.height {
                    HStack(spacing: 0) {
                        CitiesView(viewModel: viewModel, onCityInfoTap: { city in
                            cityInfoRequired = city
                        })
                            .frame(width: geometry.size.width * 0.3)
                        
                        MapView(citySelected: viewModel.citySelected)
                            .frame(width: geometry.size.width * 0.7)
                            .toolbar(.hidden, for: .navigationBar)
                    }
                } else {
                    CitiesView(viewModel: viewModel, onCellTap: {
                        path.append("MapView")
                    }, onCityInfoTap: { city in
                        cityInfoRequired = city
                    })
                    .navigationDestination(for: String.self) { value in
                        if value == "MapView" {
                            MapView(citySelected: viewModel.citySelected)
                        }
                    }
                }
            }
        }
        .sheet(item: $cityInfoRequired) { city in
            CityInfoView(city: city)
                .presentationDetents([.medium])
        }
        .onViewDidLoad {
            Task {
                await viewModel.fetchCities()
            }
        }
    }
}
