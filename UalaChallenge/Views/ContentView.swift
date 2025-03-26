//
//  ContentView.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 24/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = CitiesViewModel()
    
    var body: some View {
        CitiesView(viewModel: viewModel)
    }
}
