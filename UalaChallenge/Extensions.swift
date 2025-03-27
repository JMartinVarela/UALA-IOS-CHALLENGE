//
//  Extensions.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 25/03/2025.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() -> Void)?
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

struct ClearButton: ViewModifier {
    @Binding var text: String
    var showMagnifyingGlass: Bool = false
    
    func body(content: Content) -> some View {
        HStack {
            content
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.gray.opacity(0.7))
                        .frame(width: 22, height: 22)
                }
            } else {
                if showMagnifyingGlass {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color.gray.opacity(0.8))
                }
            }
        }
    }
}

extension View {
   func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
    
    func clearButton(text: Binding<String>, showMagnifyingGlass: Bool = false) -> some View {
        modifier(ClearButton(text: text, showMagnifyingGlass: showMagnifyingGlass))
    }
    
    /// Hide or show the view based on a boolean value.
    /// Allows us not build the view when isHidden = true, so we get the free space back
    @ViewBuilder
    public func isHidden(_ hidden: Bool) -> some View {
        self.opacity(hidden ? 0 : 1)
            .frame(width: hidden ? 0 : nil, height: hidden ? 0 : nil)
    }
}
