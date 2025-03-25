//
//  ContentView.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 24/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(Array(viewModel.cities.enumerated()), id: \.offset) { index, city in
                        Button {
                            withAnimation {
                                viewModel.citySelected = city
                            }
                        } label: {
                            CityCellView(model: city)
                        }
                        .background(city == viewModel.citySelected ?
                                    Color.blue.opacity(0.5) :
                                        (index.isMultiple(of: 2) ? Color.clear : Color.gray.opacity(0.2) ))
                    }
                }
            }
        }
        .onViewDidLoad {
            Task {
                await viewModel.fetchCities()
            }
        }
    }
    
    struct CityCellView: View {
        let model: City
        
        var body: some View {
            VStack(spacing: 5) {
                Text("\(model.name), \(model.country)")
                    .font(.headline)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("lat: \(model.coordinate.lat) long: \(model.coordinate.lon)")
                    .font(.footnote)
                    .foregroundStyle(Color.gray.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 15)
            .padding(.leading, 8)
        }
    }
}

#Preview {
    ContentView()
}
