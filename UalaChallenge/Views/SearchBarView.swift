//
//  SearchBarView.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 26/03/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    let placeholder: String = "Filter"
    
    var body: some View {
        HStack {
            TextField("",
                      text: $text,
                      prompt: Text(placeholder)
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(Color.gray.opacity(0.8))
            )
            .clearButton(text: $text, showMagnifyingGlass: true)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(Color.black)
        }
        .padding(.horizontal, 20)
        .frame(height: 42)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .inset(by: 0.5)
                .stroke(Color.gray.opacity(0.8), lineWidth: 2)
        )
        .cornerRadius(10)
    }
}
