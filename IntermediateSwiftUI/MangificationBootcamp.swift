//
//  MangificationBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 13.02.2025.
//

import SwiftUI

struct MangificationBootcamp: View {
    
    
    @State var currentAmount: CGFloat = 0
    @State var firstAmount: CGFloat = 0
    
    var body: some View {
        
        VStack {
            HStack {
                Circle().frame(width: 40, height: 40, alignment: .center)
                    .foregroundStyle(.gray.opacity(0.4))
                Text("Mustafa Ölmezses")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal
            )
            Rectangle()
                .frame(height: 420)
                .scaleEffect(1 + currentAmount)
                .foregroundStyle(.black)
                .gesture(
                    MagnificationGesture()
                        .onChanged({ value in
                            currentAmount = value - 1
                        })
                        .onEnded({ value in
                            withAnimation(.spring){
                                currentAmount = 0
                            }
                        })
                )
            HStack {
                Image(systemName: "heart")
                Image(systemName: "bubble")
                Image(systemName: "paperplane")
                Spacer()
            }
            .imageScale(.large)
            .font(.title3)
            .padding(.horizontal)
            Text("This is caption for Instagram pıstfor Instagram pıst")

        }
        
        
//        Text("Hello, World!")
//            .foregroundStyle(.white)
//            .font(.title)
//            .padding(40)
//            .background(Color.indigo)
//            .clipShape(RoundedRectangle(cornerRadius: 12))
//            .scaleEffect(1 + currentAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged({ value in
//                        currentAmount = value - 1
//                    })
//                    .onEnded({ value in
//                        currentAmount = firstAmount
//                    })
//            )
    }
}

#Preview {
    MangificationBootcamp()
}
