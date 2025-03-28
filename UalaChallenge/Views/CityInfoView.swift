//
//  CityInfoView.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 27/03/2025.
//

import SwiftUI

struct CityInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    let city: City
    
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Image(systemName: "info.square.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(Color.black.opacity(0.7))
                
                Text("Information")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.black.opacity(0.7))
            }
            
            
            VStack(spacing: 15) {
                HStack {
                    Text("City name")
                        .font(.system(size: 16))
                        .foregroundStyle(Color.gray.opacity(0.7))
                    
                    Spacer()
                    
                    Text("\(city.name)")
                        .font(.system(size: 16))
                        .foregroundStyle(Color.black)
                }
                
                HStack {
                    Text("Country")
                        .font(.system(size: 16))
                        .foregroundStyle(Color.gray.opacity(0.7))
                    
                    Spacer()
                    
                    Text("\(city.country)")
                        .font(.system(size: 16))
                        .foregroundStyle(Color.black)
                }
                
                HStack {
                    Text("Coordinates")
                        .font(.system(size: 16))
                        .foregroundStyle(Color.gray.opacity(0.7))
                        .padding(.bottom, 8)
                    
                    Spacer()
                    
                    VStack {
                        Text("Latitude: \(city.coordinate.lat)")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Text("Longitude: \(city.coordinate.lat)")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            .padding(25)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            .padding(.horizontal, 25)
            
            
            Button {
                dismiss()
            } label: {
                Text("Close")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.white)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(20)
            }
            
        }
    }
}
