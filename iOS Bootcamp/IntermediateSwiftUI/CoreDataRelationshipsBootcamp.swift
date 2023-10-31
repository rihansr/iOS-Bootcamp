//
//  CoreDataRelationshipsBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 27/10/2023.
//

import SwiftUI
import Combine
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
    
    func fetch<T>(name: String, sortBy: [NSSortDescriptor]? = [], filterBy: NSPredicate? = nil) -> [T] where T : NSFetchRequestResult{
        do {
            let request = NSFetchRequest<T>(entityName: name)
            request.sortDescriptors = sortBy
            request.predicate = filterBy
            return try context.fetch(request)
        } catch let error {
            print("Fetching Error: \(error)")
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

enum TypeOption: String, CaseIterable {
    case business, department, employee
    
    var entity: String {
        switch self {
        case .business:
            return "BusinessEntity"
        case .department:
            return "DepartmentEntity"
        case .employee:
            return "EmployeeEntity"
        }
    }
}

enum SortOption: String, CaseIterable {
    case ascending, descending
}

class CoreDataRelationshipsViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var selectedType:TypeOption = .business
    @Published var selectedSoting:SortOption = .ascending
    @Published var sortBy:[TypeOption:SortOption] = [:]
    @Published var selectedBusinesses: [BusinessEntity] = []
    @Published var selectedDepartments: [DepartmentEntity] = []
    @Published var selectedEmployees: [EmployeeEntity] = []
    private var cancelables = Set<AnyCancellable>()
    
    @Published var text: String = ""
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init(){
        fetch()
        $selectedType
            .dropFirst()
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] option in
            self?.reset()
        }
        .store(in: &cancelables)
        
        $sortBy
            .dropFirst()
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] option in
            self?.fetch()
        }
        .store(in: &cancelables)
    }
    
    func fetch(){
        businesses = sort(type: .business, by: \BusinessEntity.name)
        departments = sort(type: .department, by: \DepartmentEntity.name)
        employees = sort(type: .employee, by: \EmployeeEntity.name)
    }
    
    func sort<T: NSFetchRequestResult, Root, Value>(type: TypeOption, by: KeyPath<Root, Value>) -> [T]{
        manager.fetch(
            name: type.entity,
            sortBy: [
                NSSortDescriptor(keyPath: by, ascending: sortBy[type] == .ascending)
            ]
        )
    }
    
    func add(){
        guard !text.isEmpty else { return }
        switch selectedType {
        case .business:
            let business = BusinessEntity(context: manager.context)
            business.name = text
            if !selectedDepartments.isEmpty {
                business.departments = Set(selectedDepartments) as NSSet
            }
            if !selectedEmployees.isEmpty {
                business.employees = Set(selectedEmployees) as NSSet
            }
            break
        case .department:
            let department = DepartmentEntity(context: manager.context)
            department.name = text
            if !selectedBusinesses.isEmpty {
                department.businesses = Set(selectedBusinesses) as NSSet
            }
            if !selectedEmployees.isEmpty {
                department.employees = Set(selectedEmployees) as NSSet
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
        reset()
    }
    
    func delete(item: NSManagedObject){
        manager.context.delete(item)
        save()
    }
    
    private func selectedIndex<T: NSFetchRequestResult>(entities: [T], entity: T) -> Int? {
        if let index = entities.firstIndex(where: { _entity in
            entity.isEqual(_entity)
        }){
            return index
        }
        else {
            return nil
        }
    }
    
    func onSelect<T: NSFetchRequestResult>(entities: inout [T], entity: T){
        if let index = selectedIndex(entities: entities, entity: entity){
            entities.remove(at: index)
        }
        else{
            switch selectedType {
            case .employee:
                entities = [entity]
                break
            default:
                entities.append(entity)
            }
        }
    }
    
    func save(){
        manager.save()
        fetch()
    }
    
    func filter<T>(option: TypeOption, by: NSPredicate?) -> [T] where T: NSFetchRequestResult {
        return manager.fetch(name: "\(option.rawValue.capitalized)Entity", filterBy: by)
    }
    
    func filterDepartments(item: BusinessEntity?) -> [DepartmentEntity]{
        guard let item = item else { return departments }
        //let predicate = NSPredicate(format: "name == %@", "IT")
        let predicate = NSPredicate(format: "ANY businesses == %@", item)
        return filter(option: .department, by: predicate)
    }
    
    func reset(){
        selectedBusinesses = []
        selectedDepartments = []
        selectedEmployees = []
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
                            selection: $viewmodel.selectedType,
                            label: Text(viewmodel.selectedType.rawValue),
                            content: {
                                ForEach(TypeOption.allCases, id: \.self){
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
                                .onSubmit {
                                    viewmodel.add()
                                }
                            
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
                    
                    sortLabel(label: "BUSINESS'S", icon: "briefcase.fill", type: .business)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(viewmodel.businesses){
                                businessItemView(item: $0)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    sortLabel(label: "DEPARTMENT'S", icon: "point.3.filled.connected.trianglepath.dotted", type: .department)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(viewmodel.departments){
                                departmentItemView(item: $0)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    sortLabel(label: "EMPLOYEE'S", icon: "person.2.fill", type: .employee)
                    
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
        VStack(alignment: .leading, spacing: 0){
            Button {
                if(viewmodel.selectedType != .business){
                        viewmodel.onSelect(entities: &viewmodel.selectedBusinesses, entity: item)
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
                        ForEach(departments) { department in
                            removeLabel(name: department.name ?? "") {
                                item.removeFromDepartments(department)
                                viewmodel.save()
                            }
                        }
                    }
                }
                Section(
                    header:
                        Menu {
                            ForEach(viewmodel.employees){ employee in
                                Button(employee.name ?? ""){
                                    item.addToEmployees(employee)
                                    employee.department = nil
                                    viewmodel.save()
                                }
                            }
                        } label: {
                            addLabel(name: "Employee's")
                        }
                ){
                    if let employees = item.employees?.allObjects as? [EmployeeEntity]{
                        ForEach(employees) { employee in
                            removeLabel(name: employee.name ?? "") {
                                employee.business = nil
                                employee.department = nil
                                viewmodel.save()
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            Button {
                viewmodel.delete(item: item)
            } label: { deleteLabel() }
        }
        .frame(width: 216, height: 324, alignment: .leading)
        .background(background(for: viewmodel.selectedBusinesses.contains(item)).opacity(0.25))
        .border(background(for: viewmodel.selectedBusinesses.contains(item)), width: 0.5)
    }
    
    func departmentItemView(item: DepartmentEntity) -> some View {
        VStack(alignment: .leading, spacing: 0){
            Button {
                if(viewmodel.selectedType != .department){
                    viewmodel.onSelect(entities: &viewmodel.selectedDepartments, entity: item)
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
                        ForEach(businesses) { business in
                            removeLabel(name: business.name ?? "") {
                                item.removeFromBusinesses(business)
                                viewmodel.save()
                            }
                        }
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
                        ForEach(employees) { employee in
                            removeLabel(name: employee.name ?? "") {
                                employee.department = nil
                                viewmodel.save()
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            Button {
                viewmodel.delete(item: item)
            } label: { deleteLabel() }
        }
        .frame(width: 216, height: 324, alignment: .leading)
        .background(background(for: viewmodel.selectedDepartments.contains(item)).opacity(0.25))
        .border(background(for: viewmodel.selectedDepartments.contains(item)), width: 0.5)
    }
    
    func employeeItemView(item: EmployeeEntity) -> some View {
        VStack(alignment: .leading, spacing: 0){
            Button {
                if(viewmodel.selectedType != .employee){
                    viewmodel.onSelect(entities: &viewmodel.selectedEmployees, entity: item)
                }
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
                        removeLabel(name: business.name ?? "") {
                            item.business = nil
                            item.department = nil
                            viewmodel.save()
                        }
                    }
                }
                Section(
                    header:
                        Menu {
                            let departments = viewmodel.filterDepartments(
                                item: item.business)
                            ForEach(departments){ department in
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
                        removeLabel(name: department.name ?? "") {
                            item.department = nil
                            viewmodel.save()
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            Button {
                viewmodel.delete(item: item)
            } label: { deleteLabel() }
        }
        .frame(width: 216, height: 272, alignment: .leading)
        .background(background(for: viewmodel.selectedEmployees.contains(item)).opacity(0.25))
        .border(background(for: viewmodel.selectedEmployees.contains(item)), width: 0.5)
    }
}

extension CoreDataRelationshipsBootcamp {
    func label(name:String?) -> some View {
        Text(name ?? "")
            .foregroundColor(.black)
            .font(.headline)
            .frame(maxWidth:.infinity, alignment: .center)
            .padding()
    }
    
    func sortLabel(label: String, icon: String, type: TypeOption) -> some View {
        HStack{
            Label(label, systemImage: icon)
            Spacer()
            Menu {
                ForEach(SortOption.allCases, id: \.self, content: {
                    item in Button(item.rawValue.capitalized){
                        viewmodel.sortBy[type] = item
                    }
                })
            } label: {
                Image(systemName: "rectangle.stack")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
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
    
    func removeLabel(name:String, onTap: @escaping () -> Void) -> some View {
        HStack(alignment: .center){
            Text(name)
                .font(.caption)
            Spacer()
            Image(systemName: "minus.circle")
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.gray)
                .onTapGesture {
                    onTap()
                }
        }
    }
    
    func deleteLabel() -> some View {
        Image(systemName: "xmark.bin.circle.fill")
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.all, 6)
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
