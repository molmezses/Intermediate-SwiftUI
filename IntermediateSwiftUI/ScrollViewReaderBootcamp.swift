//
//  ScrollViewReaderBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 15.02.2025.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            TextField("Enter a # here to scroll to it", text: $textFieldText)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.indigo.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .font(.headline)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            
            Button("CLICK HERE TO BOTTOM ") {
                withAnimation(.spring){
                    if let index = Int(textFieldText){
                        scrollToIndex = index
                    }
//                    proxy.scrollTo(49, anchor: .bottom)
                }
            }
            
                
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.indigo)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { oldValue, newValue in
                        withAnimation(.spring){
                            proxy.scrollTo(newValue, anchor: .bottom)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
