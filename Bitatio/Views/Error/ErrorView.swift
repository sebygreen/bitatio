//
//  ErrorView.swift
//  Bitatio
//
//  Created by Sebastien Green on 06/04/2023.
//

import SwiftUI

struct ErrorView: View {
    let errorModel: ErrorModel
    
    @State private var size: CGSize = .zero
    
    var body: some View {
        VStack (spacing: 10) {
            Image(systemName: "exclamationmark.octagon.fill")
                .font(.system(size: 32))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.red)
            Text(errorModel.errorDescription)
                .font(.title3)
                .bold()
            Text(errorModel.errorReason)
                .multilineTextAlignment(.center)
                .monospaced()
//                .padding(8)
//                .background(Color.primary.opacity(0.1))
//                .cornerRadius(10, antialiased: true)
        }
        .padding()
        .background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self) { newSize in
            size.height = newSize.height
        }
        .presentationDetents([.height(size.height)])
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { value = nextValue() }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorModel: ErrorModel(
            errorDescription: "Dummy Error",
            errorReason: "Dummy error reason that is quite long"))
    }
}
