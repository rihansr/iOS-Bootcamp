//
//  DatePickerBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 22/09/2023.
//

import SwiftUI

struct DatePickerBootcamp: View {
    
    @State var selectedDate: Date = Date()
    
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023)) ?? Date()
    
    let endingDate: Date = Date()
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        return formatter
    }
    
    var body: some View {
        VStack{
            Text("Selected Date")
            Text(dateFormatter.string(from: selectedDate))
                .font(.headline)
            
            DatePicker(
                "Choose a date",
                selection: $selectedDate,
                in: startingDate...endingDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .accentColor(.blue)
            .datePickerStyle(CompactDatePickerStyle())
            //.datePickerStyle(GraphicalDatePickerStyle())
            //.datePickerStyle(WheelDatePickerStyle())
            .padding(.all)
        }
    }
}

struct DatePickerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerBootcamp()
    }
}
