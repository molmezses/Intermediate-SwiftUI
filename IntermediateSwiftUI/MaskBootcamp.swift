//
//  MaskBootcamo.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 15.02.2025.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        ZStack {
            StarsView
                .overlay {OverlayView.mask(StarsView)}
        }
    }
    
    private var OverlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment:.leading){
                Rectangle()
                    .foregroundStyle(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false) //->  Yoldızların üzerindeki Rectangle'ın üzerine tıklama özelliğini kapattık
    }
    
    private var StarsView: some View {
        HStack{
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            rating = index
                        }
                    }
            }
        }
    }
}

#Preview {
    MaskBootcamp()
}
