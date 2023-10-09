//
//  PickerBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 22/09/2023.
//

import SwiftUI

struct PickerBootcamp: View {
    @State var age:Int = 29
    @State var selection: String = "Most Popular"
    let filterOptions: [String] = [
        "Most Recent", "Most Popular", "Most Liked"
    ]
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .blue
                
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.white
        ]
        
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
        
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Label("TAB", systemImage: "tablecells.fill")
                Picker(
                    selection: $selection,
                    label: Text("Picker"),
                    content: {
                        ForEach(filterOptions, id: \.self, content: {
                            index in Text("\(index)").tag(index)
                        })
                    }
                )
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                
                Label("POPUP", systemImage: "arrowtriangle.up.fill")
                Picker(
                    selection: $selection,
                    label: HStack {
                        Text("Filter:")
                        Text(selection)
                    }
                        .foregroundColor(.white)
                        .padding(.all)
                        .padding(.horizontal)
                        .background(.blue)
                        .cornerRadius(10)
                        .shadow(color: .blue, radius: 0.3, x: 0, y:10)
                    ,
                    content: {
                        ForEach(filterOptions, id: \.self, content: {
                            item in Text(item).tag(item)
                        })
                    }
                )
                //.pickerStyle(DefaultPickerStyle())
                .pickerStyle(MenuPickerStyle())
                
                Menu {
                    ForEach(filterOptions, id: \.self, content: {
                        item in Button(item){
                            selection = item
                        }
                    })
                } label: {
                    Text("Menu")
                        .foregroundColor(.white)
                        .padding(.all)
                        .padding(.horizontal)
                        .background(.blue)
                        .cornerRadius(10)
                        .shadow(color: .blue, radius: 0.3, x: 0, y:10)
                }
                
                Spacer()

                Label("WHEEL", systemImage: "steeringwheel")
                Picker(
                    selection: $age,
                    label: Text("Picker"),
                    content: {
                        ForEach(18..<100, content: {
                            index in Text("\(index)").tag(index)
                        })
                    }
                )
                .pickerStyle(WheelPickerStyle())
                //.pickerStyle(InlinePickerStyle())
                
                Spacer()
            }
            .padding(.all)
            .navigationTitle(Text("Picker"))
        }
    }
}

struct PickerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PickerBootcamp()
    }
}
