//
//  StepperBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 22/09/2023.
//

import SwiftUI

struct StepperBootcamp: View {
    @State var stepperValue: Int = 10
    @State var widthIncrement: CGFloat = 25.0
    var body: some View {
        VStack(spacing: 48){
            Stepper(
                "Stepper : \(stepperValue)",
                value: $stepperValue)
            
            Stepper(
                "Stepper : \(stepperValue)",
                value: $stepperValue,
                in: 1...100
            )
            
            Stepper("Stepper") {
                incrementWidth(amount: 25)
            } onDecrement: {
                incrementWidth(amount: -25)
            }
            
            Rectangle()
                .frame(
                    width: 100 + widthIncrement,
                    height: 100
                )
                .cornerRadius(widthIncrement/10)
        }
        .padding()
    }
    
    func incrementWidth(amount: CGFloat){
        withAnimation(.easeInOut) {
            widthIncrement += amount
        }
    }
}

struct StepperBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StepperBootcamp()
    }
}
