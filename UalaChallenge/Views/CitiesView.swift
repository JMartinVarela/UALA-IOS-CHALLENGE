//
//  CitiesView.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 25/03/2025.
//

import SwiftUI

struct CitiesView: View {
    private let fade = AnyTransition.opacity.animation(Animation.linear(duration: 0.5))
    
    @State var viewModel: CitiesViewModel
    
    var onCellTap: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBarView(text: $viewModel.searchText)
                .padding()
                .isHidden(!viewModel.showSearchBar)
            
            switch viewModel.loadingCitiesState {
            case .loading:
                SkeletonCitiesListView(viewModel: viewModel)
                    .transition(fade)
            case .loaded:
                if viewModel.cities.isEmpty {
                    EmptyCitiesView()
                        .transition(fade)
                } else {
                    CitiesListView(viewModel: viewModel) {
                        onCellTap?()
                    }
                        .transition(fade)
                }
            case .error:
                ErrorView(viewModel: viewModel)
                    .transition(fade)
            }
        }
    }
    
    private struct SkeletonCitiesListView: View {
        @State var viewModel: CitiesViewModel
        
        var body: some View {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(Array(viewModel.skeletonCities.enumerated()), id: \.offset) { index, city in
                        CityCellView(model: city, isFavorite: viewModel.isFavorite(city))
                            .redacted(reason: .placeholder)
                            .background(city == viewModel.citySelected ?
                                        Color.blue.opacity(0.5) :
                                            (index.isMultiple(of: 2) ? Color.clear : Color.gray.opacity(0.2) ))
                    }
                }
            }
        }
    }
    
    private struct CitiesListView: View {
        @State var viewModel: CitiesViewModel
        var onCellTap: (() -> Void)?
        
        var body: some View {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(Array(viewModel.filteredCities.enumerated()), id: \.offset) { index, city in
                        Button {
                            withAnimation {
                                viewModel.citySelected = city
                            }
                            onCellTap?()
                        } label: {
                            CityCellView(model: city, isFavorite: viewModel.isFavorite(city)) {
                                viewModel.toogleFavoriteCity(city)
                            }
                        }
                        .background(city == viewModel.citySelected ?
                                    Color.blue.opacity(0.5) :
                                        (index.isMultiple(of: 2) ? Color.clear : Color.gray.opacity(0.2) ))
                    }
                }
            }
        }
    }
    
    private struct EmptyCitiesView: View {
        var body: some View {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    Spacer()
                    
                    VStack(spacing: 5) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 35, weight: .regular))
                        
                        Text("No hay ciudades para mostrar")
                            .font(.system(size: 18, weight: .regular))
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(minHeight: geometry.size.height)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width)
            }
        }
    }
    
    private struct ErrorView: View {
        @State var viewModel: CitiesViewModel
        
        var body: some View {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    Spacer()
                    
                    VStack(spacing: 5) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 35, weight: .regular))
                            .foregroundColor(Color.red)
                        
                        Text("Hubo un error al intentar cargar los datos. Intente nuevamente más tarde.")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(minHeight: geometry.size.height)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width)
                .refreshable {
                    await viewModel.fetchCities()
                }
            }
        }
    }
    
    private struct CityCellView: View {
        let model: City
        let isFavorite: Bool
        
        var onFavoriteTap: (() -> Void)?
        
        var body: some View {
            HStack {
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
                
                Spacer()
                
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .font(.system(size: 26))
                    .foregroundColor(.yellow)
                    .padding(.trailing, 14)
                    .onTapGesture {
                        onFavoriteTap?()
                    }
            }
        }
    }
}
