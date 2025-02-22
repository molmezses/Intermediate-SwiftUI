//
//  WeakSelfBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 22.02.2025.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count : Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationStack{
            NavigationLink("Navigate") {
                WeakSelfSecondScreen()
            }
            .navigationTitle("Screen1")
        }
        .overlay (
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(.indigo)
                .mask(RoundedRectangle(cornerRadius: 12))
                .padding(.trailing)
                .foregroundStyle(.white)
            ,alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var viewModel = WeakSelfSecondScreenViewModel()
    
     var body: some View {
         VStack {
             Text("Second View")
                 .font(.largeTitle)
                 .foregroundStyle(.red)
             
             if let data = viewModel.data{
                 Text(data)
             }
         }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITIALLIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData(){
        // Uygulamada kullanıcının veri indirdiği gibi durumlarda veya o anki sayfada yapılacak bir miktar iş olduğu zamanlarda kullanıcı sayfayı kapattığı zaman veriyi indirmeye işlemleri yapmaya devam eder ve geçerli sayfanın işlmeine devam etmeisne gerek yoktur çünkü sayfadaki işlemler iptal olmuşyur
        DispatchQueue.main.asyncAfter(deadline: .now() + 400){ [weak self] in
            self?.data = "New Data"
        }
    }
}

#Preview {
    WeakSelfBootcamp()
}
