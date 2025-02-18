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
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        fetchBusiness()
        fetchDepartments()
        fetchEmployee()
    }
    
    func fetchBusiness(){
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        do{
            businesses = try manager.context.fetch(request)
        }catch{
            print("ERROR fetching Business Entity \(error.localizedDescription)")
        }
    }
    
    func fetchDepartments(){
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do{
            departments = try manager.context.fetch(request)
        }catch {
            print("Error fetching Department request \(error.localizedDescription)")
        }
    }
    
    func fetchEmployee(){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do{
            employees = try manager.context.fetch(request)
        }catch {
            print("Error fetching Employee request \(error.localizedDescription)")
        }
    }
    
    func addBusiness(){
        let newBusinnes = BusinessEntity(context: manager.context)
        newBusinnes.name = "Microsoft"
        //add existing department to the new Business
        newBusinnes.departments = [departments[0] , departments[1]]
        
        //add existing employess to the new business
        newBusinnes.employees = [employees[1]]
        
        //add new business to existinf department
        save()
    }
    
    func addDepertment(){
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name  = "Engineering"
        //newDepartment.employees = [employees[0]]
        //alternatif
        newDepartment.addToEmployees(employees[1])
//        newDepartment.businesses =  [businesses[0]]
        save()
    }
    
    func addEmployee(){
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Ece"
        newEmployee.age = 21
        newEmployee.dateJoined = Date()
//        newEmployee.departments = departments[0]
//        newEmployee.business = businesses[0]
        save()
    }
    
    func deleteBusiness(entity: EmployeeEntity){
        manager.container.viewContext.delete(entity)
        save()
    }
    
    func save(){
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.fetchBusiness()
            self.fetchDepartments()
            self.fetchEmployee()
            self.manager.save()
        }
    }
    
}

struct CoreDataRelationShipsBootcamp: View {
    
    @StateObject var viewModel = CoreDataRelationShipsViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(){
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
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(viewModel.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(viewModel.employees) { employee in
                                EmployeeView(entity: employee)
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
            HStack(spacing: 12){
                
                VStack{
                    Text("Name")
                        .bold()
                        .foregroundStyle(.black)
                        .underline()
                    Text("\(entity.name ?? "Noname")")
                }
                
                if let departments = entity.departments?.allObjects as? [DepartmentEntity]{
                    VStack{
                        Text("Departments:")
                            .bold()
                            .foregroundStyle(.black)
                            .underline()
                        ForEach(departments) { department in
                            Text(department.name ?? "No")
                        }
                    }
                }
                
                if let employess = entity.employees?.allObjects as? [EmployeeEntity]{
                    VStack {
                        Text("Employees:")
                            .bold()
                            .foregroundStyle(.black)
                            .underline()
                        ForEach(employess) { employee in
                            Text(employee.name ?? "No")
                        }
                    }
                }
            }
            
        }
        .padding()
        .background(Color.indigo.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .foregroundStyle(.white)
        .padding(.horizontal)
    }
}

struct DepartmentView: View{
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(spacing: 20){
            HStack(spacing: 12){
                
                VStack{
                    Text("Name")
                        .bold()
                        .foregroundStyle(.black)
                        .underline()
                    Text("\(entity.name ?? "Noname")")
                }
                
                if let business = entity.businesses?.allObjects as? [BusinessEntity]{
                    VStack{
                        Text("Businesses:")
                            .bold()
                            .foregroundStyle(.black)
                            .underline()
                        ForEach(business) { business in
                            Text(business.name ?? "No")
                        }
                    }
                }
                
                if let employess = entity.employees?.allObjects as? [EmployeeEntity]{
                    VStack {
                        Text("Employees:")
                            .bold()
                            .foregroundStyle(.black)
                            .underline()
                        ForEach(employess) { employee in
                            Text(employee.name ?? "No")
                        }
                    }
                }
            }
            
        }
        .padding()
        .background(Color.green.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .foregroundStyle(.white)
        .padding(.horizontal)
    }
}

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(spacing: 20){
            HStack(spacing: 12){
                
                VStack{
                    Text("Name")
                        .bold()
                        .foregroundStyle(.black)
                        .underline()
                    Text("\(entity.name ?? "Noname")")
                }
                
                VStack {
                    Text("Age:")
                        .bold()
                        .foregroundStyle(.black)
                        .underline()
                    Text("\(entity.age)")
                }
                
                
                VStack {
                    Text("Business:")
                        .bold()
                        .foregroundStyle(.black)
                        .underline()
                    Text("\(entity.business?.name ?? "Noname")")
                }
                
                VStack {
                    Text("Department:")
                        .bold()
                        .foregroundStyle(.black)
                        .underline()
                    Text("\(entity.departments?.name ?? "Noname")")
                }
                
                
            }
            
        }
        .padding()
        .background(Color.teal.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .foregroundStyle(.white)
        .padding(.horizontal)
    }
}


#Preview {
    CoreDataRelationShipsBootcamp()
}
