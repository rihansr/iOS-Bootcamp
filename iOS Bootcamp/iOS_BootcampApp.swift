//
//  iOS_BootcampApp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 09/10/2023.
//

import SwiftUI

@main
struct iOS_BootcampApp: App {
    
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            StructClassActorBootcamp()
//            NavigationStack{
//                TasksView()
//            }
//            .navigationViewStyle(.stack)
//            .environmentObject(taskViewModel)
        }
    }
}
