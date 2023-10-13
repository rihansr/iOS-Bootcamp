//
//  TaskModel.swift
//  TodoList
//
//  Created by Macuser on 05/10/2023.
//

import Foundation

struct TaskModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func toggle() -> TaskModel{
        return TaskModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
