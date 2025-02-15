//
//  GeometryReaderBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 15.02.2025.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        //GeometryReaderBootcampSize()
        ScrollView(.horizontal){
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 12)
                            .rotation3DEffect(Angle(degrees: getPercentage(geo: geometry) * 40), axis: (x: 0, y: 1, z: 0))
                    }
                    .foregroundStyle(.indigo)
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}


struct GeometryReaderBootcampSize: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing:0){
                Rectangle().fill(Color.indigo)
                    .frame(width: geometry.size.width * 0.66)
                Rectangle().fill(Color.teal)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    GeometryReaderBootcamp()
}
