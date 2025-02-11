//
//  LongPressGestureBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 11.02.2025.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isComplate: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack{
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isComplate ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity , alignment: .leading)
                .background(Color.gray)
            
            HStack{
                Text("Click Here")
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                        //at the min duration
                        withAnimation(.easeInOut){
                            isSuccess = true
                        }
                    } onPressingChanged: { isPressing in
                        //start of press -> min duration
                        if isPressing{
                            withAnimation(.easeInOut(duration: 1.0)){
                                isComplate = true
                            }
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                if !isSuccess{
                                    withAnimation(.easeInOut){
                                        isComplate = false
                                    }
                                }
                            }
                        }
                    }

                
                Text("Reset")
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .onTapGesture {
                        isSuccess = false
                        isComplate = false
                    }
            }
        }
        
        
        
        
        
//        Text(isComplate ? "COMPLATED " : "NOT  COMPLATE")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplate ? .green : .red)
//            .foregroundStyle(.white)
//            .onLongPressGesture(minimumDuration: 2.0){
//                isComplate.toggle()
//            }
    }
}

#Preview {
    LongPressGestureBootcamp()
}
