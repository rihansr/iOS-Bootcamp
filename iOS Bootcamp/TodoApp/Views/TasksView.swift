//
//  TaskListView.swift
//  TodoList
//
//  Created by Macuser on 28/09/2023.
//

import SwiftUI

struct TasksView: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var body: some View {
        ZStack{
            if taskViewModel.isLoading
            {
                ProgressView()
            }
            else{
                if(taskViewModel.tasks.isEmpty){
                    NoTasksView()
                }
                else{
                    List {
                        ForEach(taskViewModel.tasks){ task in
                            TaskItem(task: task)
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.2)) {
                                        taskViewModel.update(task: task)
                                    }
                                }
                        }
                        .onMove(perform: taskViewModel.move)
                        .onDelete(perform: taskViewModel.remove)
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .navigationTitle("Todo List")
        .navigationBarItems(leading: EditButton(), trailing: NavigationLink("Add", destination:  AddView()))
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            NavigationStack{
                TasksView()
            }
            NavigationStack{
                TasksView()
            }
            .preferredColorScheme(.dark)
        }
        .environmentObject(TaskViewModel())
    }
}
