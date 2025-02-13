//
//  RotationGestureBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 13.02.2025.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .padding(40)
            .background(Color.indigo)
            .foregroundStyle(.windowBackground)
            .mask(RoundedRectangle(cornerRadius: 12))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged({ value in
                        angle = value
                    })
                    .onEnded({ value in
                        withAnimation(.spring){
                            angle = Angle(degrees: 0)
                        }
                    })
            )
    }
}

#Preview {
    RotationGestureBootcamp()
}
