//
//  TaskViewModel.swift
//  TodoList
//
//  Created by Macuser on 28/09/2023.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks : [TaskModel] = [] {
        didSet {
            save()
        }
    }
    @Published var isLoading : Bool = false
    let storageKey : String = "storage_key"
    
    init(){
        getTasks()
    }
    
    func getTasks(){
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.isLoading = false
            guard
                let data = UserDefaults.standard.data(forKey: self.storageKey),
                let savedTasks = try? JSONDecoder().decode([TaskModel].self, from: data) else {
                return
            }
            self.tasks = savedTasks
        })
    }
    
    func add(title: String) {
        guard !title.isEmpty else {
            return
        }
        
        tasks.append(TaskModel(title: title, isCompleted: false))
    }
    
    func remove(indexSet: IndexSet){
        tasks.remove(atOffsets: indexSet)
    }
    
    func move(indexSet: IndexSet, index: Int){
        tasks.move(fromOffsets: indexSet, toOffset: index)
    }
    
    func update(task: TaskModel){
        if let index = tasks.firstIndex(where: {
            task.id == $0.id
        }){
            tasks[index] = task.toggle()
        }
    }
    
    func save() {
        if let encodedData = try? JSONEncoder().encode(tasks){
            UserDefaults.standard.set(encodedData, forKey: storageKey)
        }
    }
}
