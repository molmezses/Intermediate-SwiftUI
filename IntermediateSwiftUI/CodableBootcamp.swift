//
//  CodableBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 22.02.2025.
//

import SwiftUI

struct CustomerModel : Identifiable , Codable {
    let id: String
    let name: String
    let point: Int
    let isPremium: Bool
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData(){
        guard let data = getJSONData() else {return}
        
        do{
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        }catch{
            print("Error JSONDecoder \(error.localizedDescription)")
        }
        

    }
    
    func getJSONData() -> Data?{
        
        let customer = CustomerModel(id: "1", name: "Emilt", point: 23, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)
        
        return jsonData
    }
    
}

struct CodableBootcamp: View {
    
    @StateObject var viewModel = CodableViewModel()
    
    var body: some View {
        VStack {
            if let customer = viewModel.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.point)")
                Text(customer.isPremium.description)
            }
        }
    }
}

#Preview {
    CodableBootcamp()
}
