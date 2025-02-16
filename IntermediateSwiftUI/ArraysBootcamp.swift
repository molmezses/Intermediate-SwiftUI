//
//  ArraysBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 16.02.2025.
//

import SwiftUI

struct UserModel : Identifiable {
    let id = UUID().uuidString
    let name: String
    let point: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filterArray: [UserModel] = []
    @Published var filterArray2: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init(){
        getUser()
        updateFilteredArray()
    }
    
    func getUser(){
        let user1 = UserModel(name: "Mustafa", point: 99, isVerified: true)
        let user2 = UserModel(name: "Eda", point: 23, isVerified: false)
        let user3 = UserModel(name: "Ahmet", point: 35, isVerified: true)
        let user4 = UserModel(name: "Cihan", point: 12, isVerified: false)
        let user5 = UserModel(name: "Samet", point: 22, isVerified: false)
        let user6 = UserModel(name: "Ömer", point: 7, isVerified: true)
        let user7 = UserModel(name: "Sezar", point: 12, isVerified: false)
        let user8 = UserModel(name: "Juliet", point: 45, isVerified: true)
        let user9 = UserModel(name: "Romeo", point: 62, isVerified: true)
        let user10 = UserModel(name: "Ece", point: 71, isVerified: false)
        
        self.dataArray.append(contentsOf: [user1,user2,user3,user4,user5,user6,user7,user8,user9,user10] )
    }
    
    func updateFilteredArray(){
        //           sort
        
        //user1 user2 den puanı büyükse onu ömnceye koyar
        //kısa yolu $0 user1 #1 user2 anlamına geelkir
//        filterArray =  dataArray.sorted { user1, user2 -> Bool in
//            return user1.point > user2.point
//        }
//        filterArray = dataArray.sorted(by: {$0.point > $1.point})
        
        
        //      filter
        //puanu 50 den fazla olan kişileri filretledik ve verified olanları
        filterArray = dataArray.filter({ user -> Bool in
//            return user.point > 40
            return user.isVerified
//            return user.name.contains("r")
        })
        
        filterArray2 = dataArray.filter({$0.isVerified})
        
        //    map
        
        

    }
    
}

struct ArraysBootcamp: View {
    
    @StateObject var viewModel = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.filterArray2) { user in
                    VStack(alignment: .leading){
                        Text(user.name)
                            .font(.headline)
                        HStack {
                            Text("Points: \(user.point)")
                            Spacer()
                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.indigo.clipShape(RoundedRectangle(cornerRadius: 10)))
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    ArraysBootcamp()
}
