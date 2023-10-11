//
//  TaskItem.swift
//  TodoList
//
//  Created by Macuser on 05/10/2023.
//

import SwiftUI

struct TaskItem: View {
    let task: Task
    var body: some View {
        HStack{
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isCompleted ? .green : .red)
            Text(task.title)
            Spacer()
        }
    }
}

struct TaskItem_Previews: PreviewProvider {
    static var task1 = Task(title: "First item!", isCompleted: false)
    static var task2 = Task(title: "Second item!", isCompleted: true)
    
    static var previews: some View {
        Group{
            TaskItem(task: task1)
            TaskItem(task: task2)
        }
        .previewLayout(.sizeThatFits)
    }
}
