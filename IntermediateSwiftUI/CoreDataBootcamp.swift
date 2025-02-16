//
//  CoreDataBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 16.02.2025.
//

import SwiftUI
import CoreData

class CoreDataViewModel : ObservableObject{
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitsEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("ERROR LOADİNG CORE DATA \(error.localizedDescription)")
            }else{
                print("Successfully Loaded Core Data!")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits(){
        let request = NSFetchRequest<FruitsEntity>(entityName: "FruitsEntity")
        
        do {
            savedEntities =  try container.viewContext.fetch(request)
        }catch {
            print("Error fetching \(error.localizedDescription)")
        }
    }
    
    func addFruits(text: String) {
        let newFruit = FruitsEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruits(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            fetchFruits()// -> verilerimizin güncellenmesi için 32.satır
        }catch{
            print("Error saving data \(error.localizedDescription)")
        }
    }
    
    func updateFruits(entity: FruitsEntity){
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    
}

struct CoreDataBootcamp: View {
    
    @StateObject var viewModel = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationStack{
            VStack(spacing:20){
                TextField("Add a Fruits", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                
                Button {
                    guard !textFieldText.isEmpty else {return}
                    viewModel.addFruits(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("SUBMİT")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding(.leading)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color(.indigo))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                }
                
                List {
                    ForEach(viewModel.savedEntities) { entity in
                        Text(entity.name ?? "NO ITEM")
                            .onTapGesture {
                                viewModel.updateFruits(entity: entity)
                            }
                    }
                    .onDelete(perform: viewModel.deleteFruits)
                }

            }
            .navigationTitle("Core Data Fruits")
        }
    }
}

#Preview {
    CoreDataBootcamp()
}
