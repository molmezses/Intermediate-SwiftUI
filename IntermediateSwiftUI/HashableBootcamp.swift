//
//  HashableBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 16.02.2025.
//

import SwiftUI

struct CustomModel: Hashable{
//    let id = UUID().uuidString
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    
    let data: [CustomModel] = [
        CustomModel(title: "One"),
        CustomModel(title: "Two"),
        CustomModel(title: "Three"),
        CustomModel(title: "Four"),
        CustomModel(title: "Five"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing:40){
                ForEach(data , id: \.self) { item in
                    Text(item.hashValue.description)
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}
