//
//  CoreDataRelationShipsBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 17.02.2025.
//


// 3 Entity

// -> BussinesEntity
// -> DepertmentEntity
// -> EmployeeEntity

import SwiftUI
import CoreData

class CoreDataManager{
    static let instance = CoreDataManager() //Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { Description, error in
            if let error = error{
                print("Error loading persistent stores: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save(){
        do{
            try context.save()
            print("Saved Succesfly!")
        }catch{
            print("ERROR Saving Context: \(error)")
        }
    }
}

class CoreDataRelationShipsViewModel: ObservableObject{
    
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    
    init() {
        fetchBusiness()
    }
    
    func fetchBusiness(){
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        do{
            businesses = try manager.context.fetch(request)
        }catch{
            print("ERROR fetching core data \(error.localizedDescription)")
        }
    }
    
    func addBusiness(){
        let newBusinnes = BusinessEntity(context: manager.context)
        newBusinnes.name = "Apple"
        save()
    }
    
//    func deleteBusiness(entity: BusinessEntity){
//        manager.container.viewContext.delete(entity)
//        save()
//    }
    
    func save(){
        manager.save()
    }
    
}

struct CoreDataRelationShipsBootcamp: View {
    
    @StateObject var viewModel = CoreDataRelationShipsViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing:20){
                    Button {
                        viewModel.addBusiness()
                    } label: {
                        Text("Peform Action")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.indigo)
                            .mask(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top){
                            ForEach(viewModel.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }

                }
            }
            .navigationTitle("RelationShips")
        }
    }
}


struct BusinessView: View {
    
    @StateObject var viewModel = CoreDataRelationShipsViewModel()
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(spacing: 20){
            Text("Name: \(entity.name ?? "No Name")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity]{
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "No")
                }
            }
            
            if let employess = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees:")
                    .bold()
                ForEach(employess) { employee in
                    Text(employee.name ?? "No")
                }
            }
        }
        .padding()
        .background(Color.indigo.opacity(0.8))
    }
}

#Preview {
    CoreDataRelationShipsBootcamp()
}
