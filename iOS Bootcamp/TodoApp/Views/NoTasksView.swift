//
//  NoTasksView.swift
//  TodoList
//
//  Created by Macuser on 05/10/2023.
//

import SwiftUI

struct NoTasksView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView{
            VStack (spacing: 10){
                Text("There ar no items")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Are you a productive person? I Think you should click the add button and add a bunch of taska to your todo list!")
                    .padding(.bottom, 20)
                
                NavigationLink(
                    destination: AddView(),
                    label: {
                        Text("Add Something")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 56)
                            .frame(maxWidth:.infinity)
                            .background(animate ? .red : .blue)
                            .cornerRadius(8)
                    })
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(
                    color: (animate ? Color.red : Color.blue).opacity(0.7), radius: animate ? 30 : 50,
                    x: 0,
                    y: animate ? 50 : 30
                )
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear{
                addAnimation()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addAnimation(){
        guard !animate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            withAnimation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever()
            ){
                animate.toggle()
            }
            
        }
    }
}

struct NoTasksView_Previews: PreviewProvider {
    static var previews: some View {
        NoTasksView()
    }
}
