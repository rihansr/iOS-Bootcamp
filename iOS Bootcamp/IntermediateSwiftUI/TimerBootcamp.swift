//
//  TimerBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 01/11/2023.
//

import SwiftUI

struct TimerBootcamp: View {
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    // Current Time
    /*
     @State var currentDate: Date = Date()
     
     var dateFormatter: DateFormatter {
         let formater = DateFormatter()
         //formater.dateStyle = .medium
         formater.timeStyle = .medium
         return formater
     }
     */
    
    // Coutdown
    /*
     @State var count:Int = 10
     @State var finishedText: String? = nil
     */
    
    // Countdown to date
    /*
     @State var timeRemaining: String = ""
     let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
     
     func updateTimeRemaining(){
         let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
         let min = remaining.minute ?? 0
         let sec = remaining.second ?? 0
         timeRemaining = "\(min):\(sec)"
     }
     */
    
    // Animation loader & Carousel slider
    @State var count: Int = 0
    
    var body: some View {
        ZStack{
            RadialGradient(
                gradient: Gradient(colors: [.blue, .indigo]),
                center: .center,
                startRadius: 5,
                endRadius: 500
            ).ignoresSafeArea()
            
            // Current Time
            /*
             text(label: dateFormatter.string(from: currentDate))
             */
            
            // Countdown
            /*
             Text(dateFormatter.string(from: currentDate))
             text(label: finishedText ?? "\(count)")
             */
            
            // Countdown to date
            /*
             text(label: timeRemaining)
             */
            
            // Animated loader
            /*
             HStack(spacing: 8){
                 Circle()
                     .offset(y: count == 1 ? -16 : 0)
                 Circle()
                     .offset(y: count == 2 ? -16 : 0)
                 Circle()
                     .offset(y: count == 3 ? -16 : 0)
             }
             .frame(width: 128)
             .foregroundColor(.white)
             */
            
            // Carousel slider
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(0)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.yellow)
                    .tag(2)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        // Current Time
        /*
         .onReceive(timer) { value in
             currentDate = value
         }
         */
        // Countdown
        /*
         .onReceive(timer) { _ in
             if(count <= 1){
                 finishedText = "WoW!"
             }
             else {
                 count -= 1
             }
         }
         */
        // Countdown to date
        /*
         .onReceive(timer) { _ in
             updateTimeRemaining()
         }
         */
        // Animated loader & Carousel slider
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 1.0)) {
                count = count == 3 ? 0 : count + 1
            }
        }
    }
    
    func text(label:String) -> some View {
        Text(label)
            .font(.system(size: 100, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
            .padding()
            .lineLimit(1)
            .minimumScaleFactor(0.1)
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
