//
//  CoreDataRelationshipsBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 27/10/2023.
//

import SwiftUI
import CoreData

class CoreDataManager{
    static let instance: CoreDataManager = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func fetch<T>(name: String) -> [T] where T : NSFetchRequestResult{
        do {
            return try context.fetch(NSFetchRequest(entityName: name))
        } catch let error {
            print("Saving Error: \(error)")
            return []
        }
    }
    
    func save(){
        do {
            try context.save()
        } catch let error {
            print("Saving Error: \(error)")
        }
    }
}

enum FilterOption: String, CaseIterable {
    case business, department, employee
}

class CoreDataRelationshipsViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var selectedOption:FilterOption = .business
    @Published var selectedBusinesses: [BusinessEntity] = []
    @Published var selectedDepartments: [DepartmentEntity] = []
    @Published var selectedEmployee: EmployeeEntity?
    
    @Published var text: String = ""
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init(){
        fetch()
    }
    
    func fetch(){
        businesses = manager.fetch(name: "BusinessEntity")
        departments = manager.fetch(name: "DepartmentEntity")
        employees = manager.fetch(name: "EmployeeEntity")
    }
    
    func add(){
        guard !text.isEmpty else { return }
        switch selectedOption {
        case .business:
            let business = BusinessEntity(context: manager.context)
            business.name = text
            if !selectedDepartments.isEmpty {
                business.departments = Set(selectedDepartments) as NSSet
            }
            if let employee = selectedEmployee {
                business.addToEmployees(employee)
            }
            break
        case .department:
            let department = DepartmentEntity(context: manager.context)
            department.name = text
            if !selectedBusinesses.isEmpty {
                department.businesses = Set(selectedBusinesses) as NSSet
            }
            if let employee = selectedEmployee {
                department.addToEmployees(employee)
            }
            break
        case .employee:
            let employee = EmployeeEntity(context: manager.context)
            employee.name = text
            if !selectedBusinesses.isEmpty{
                employee.business = selectedBusinesses.first
            }
            if !selectedDepartments.isEmpty{
                employee.department = selectedDepartments.first
            }
            break
        }
        save()
        text = ""
        selectedBusinesses = []
        selectedDepartments = []
        selectedEmployee = nil
    }
    
    func delete(item: NSManagedObject){
        manager.context.delete(item)
        save()
    }
    
    func save(){
        manager.save()
        fetch()
    }
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var viewmodel = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 20){
                    VStack(alignment: .leading, spacing: 2) {
                        Picker(
                            selection: $viewmodel.selectedOption,
                            label: Text(viewmodel.selectedOption.rawValue),
                            content: {
                                ForEach(FilterOption.allCases, id: \.self){
                                    Text($0.rawValue.capitalized).tag($0)
                                }
                            }
                        )
                        .padding(.horizontal, 6)
                        
                        HStack {
                            TextField("Type here...", text: $viewmodel.text)
                                .padding()
                                .background(Color.gray.opacity(0.15))
                                .cornerRadius(6)
                            
                            Button {
                                viewmodel.add()
                            } label: {
                                Text("Add+")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding()
                                    .padding(.horizontal)
                                    .background(.blue)
                                    .cornerRadius(6)
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                    
                    Label("BUSINESS'S", systemImage: "briefcase.fill")
                        .padding(.top)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(viewmodel.businesses){
                                businessItemView(item: $0)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Label("DEPARTMENT'S", systemImage: "point.3.filled.connected.trianglepath.dotted")
                        .padding(.top)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(viewmodel.departments){
                                departmentItemView(item: $0)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Label("EMPLOYEE'S", systemImage: "person.2.fill")
                        .padding(.top)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(viewmodel.employees){
                                employeeItemView(item: $0)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Business Brands")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension CoreDataRelationshipsBootcamp {
    func businessItemView(item: BusinessEntity) -> some View {
        VStack(alignment: .leading){
            Button {
                if viewmodel.selectedBusinesses.contains(item){
                    if let index = viewmodel.selectedBusinesses.firstIndex(of: item){
                        viewmodel.selectedBusinesses.remove(at: index)
                    }
                }
                else {
                    switch viewmodel.selectedOption {
                    case .employee:
                        viewmodel.selectedBusinesses = [item]
                        break
                    default:
                        viewmodel.selectedBusinesses.append(item)
                    }
                }
            } label: { label(name: item.name) }
            
            List{
                Section(
                    header:
                        Menu {
                            ForEach(viewmodel.departments){ department in
                                Button(department.name ?? ""){
                                    item.addToDepartments(department)
                                    viewmodel.save()
                                }
                            }
                        } label: {
                            addLabel(name: "Department's")
                        }
                ){
                    if let departments = item.departments?.allObjects as? [DepartmentEntity] {
                        ForEach(departments) { Text($0.name ?? "").font(.caption) }
                    }
                }
                Section(
                    header:
                        Menu {
                            ForEach(viewmodel.employees){ employee in
                                Button(employee.name ?? ""){
                                    item.addToEmployees(employee)
                                    viewmodel.save()
                                }
                            }
                        } label: {
                            addLabel(name: "Employee's")
                        }
                ){
                    if let employees = item.employees?.allObjects as? [EmployeeEntity]{
                        ForEach(employees) { Text($0.name ?? "").font(.caption) }
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
        .frame(width: 216, height: 324, alignment: .leading)
        .background(background(for: viewmodel.selectedBusinesses.contains(item)).opacity(0.25))
        .border(background(for: viewmodel.selectedBusinesses.contains(item)), width: 0.5)
    }
    
    func departmentItemView(item: DepartmentEntity) -> some View {
        VStack(alignment: .leading){
            Button {
                if viewmodel.selectedDepartments.contains(item){
                    if let index = viewmodel.selectedDepartments.firstIndex(of: item){
                        viewmodel.selectedDepartments.remove(at: index)
                    }
                }
                else {
                    switch viewmodel.selectedOption {
                    case .employee:
                        viewmodel.selectedDepartments = [item]
                        break
                    default:
                        viewmodel.selectedDepartments.append(item)
                    }
                }
            } label: { label(name: item.name) }
            
            List{
                Section(
                    header:
                        Menu {
                            ForEach(viewmodel.businesses){ business in
                                Button(business.name ?? ""){
                                    item.addToBusinesses(business)
                                    viewmodel.save()
                                }
                            }
                        } label: {
                            addLabel(name: "Business's")
                        }
                ){
                    if let businesses = item.businesses?.allObjects as? [BusinessEntity]{
                        ForEach(businesses) { Text($0.name ?? "").font(.caption) }
                    }
                }
                Section(
                    header:
                        Menu {
                            ForEach(viewmodel.employees){ employee in
                                Button(employee.name ?? ""){
                                    item.addToEmployees(employee)
                                    viewmodel.save()
                                }
                            }
                        } label: {
                            addLabel(name: "Employee's")
                        }
                ){
                    if let employees = item.employees?.allObjects as? [EmployeeEntity] {
                        ForEach(employees) { Text($0.name ?? "").font(.caption) }
                           
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
        .frame(width: 216, height: 324, alignment: .leading)
        .background(background(for: viewmodel.selectedDepartments.contains(item)).opacity(0.25))
        .border(background(for: viewmodel.selectedDepartments.contains(item)), width: 0.5)
    }
    
    func employeeItemView(item: EmployeeEntity) -> some View {
        VStack(alignment: .leading){
            Button {
                viewmodel.selectedEmployee = viewmodel.selectedEmployee == item ? nil : item
            } label: { label(name: item.name) }
            
            List{
                Section(
                    header:
                        Menu {
                            ForEach(viewmodel.businesses){ business in
                                Button(business.name ?? ""){
                                    item.business = business
                                    viewmodel.save()
                                }
                            }
                        } label: {
                            addLabel(name: "Business")
                        }
                ){
                    if let business = item.business {
                        Text(business.name ?? "").font(.caption)
                    }
                }
                Section(
                    header:
                        Menu {
                            ForEach(viewmodel.departments){ department in
                                Button(department.name ?? ""){
                                    item.department = department
                                    viewmodel.save()
                                }
                            }
                        } label: {
                            addLabel(name: "Department")
                        }
                ){
                    if let department = item.department {
                        Text(department.name ?? "").font(.caption)
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
        .frame(width: 216, height: 240, alignment: .leading)
        .background(background(for: viewmodel.selectedEmployee == item).opacity(0.25))
        .border(background(for: viewmodel.selectedEmployee == item), width: 0.5)
    }
    
    func label(name:String?) -> some View {
        Text(name ?? "")
            .foregroundColor(.black)
            .font(.headline)
            .frame(maxWidth:.infinity, alignment: .center)
            .padding(.top)
            .padding(.horizontal)
    }
    
    func addLabel(name:String) -> some View {
        HStack(alignment: .center){
            Image(systemName: "plus.circle")
                .foregroundColor(.gray)
            Text(name)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
    
    func background(for isSelected: Bool) -> Color {
        isSelected ? .green : .gray
    }
}

struct CoreDataRelationshipsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsBootcamp()
    }
}
