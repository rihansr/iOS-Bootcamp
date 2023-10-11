//
//  TaskModel.swift
//  TodoList
//
//  Created by Macuser on 05/10/2023.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func toggle() -> Task{
        return Task(id: id, title: title, isCompleted: !isCompleted)
    }
}
