//
//  HacticBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 25/10/2023.
//

import SwiftUI

struct HapticManager {
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticBootcamp: View {
    var body: some View {
        VStack(spacing: 20){
            Button("Success"){ HapticManager.instance.notification(type: .success) }
            Button("Waring"){ HapticManager.instance.notification(type: .warning) }
            Button("Error"){ HapticManager.instance.notification(type: .error) }
            
            Divider()
            
            Button("Soft"){ HapticManager.instance.impact(style: .soft) }
            Button("Light"){ HapticManager.instance.impact(style: .light) }
            Button("Medium"){ HapticManager.instance.impact(style: .medium) }
            Button("Rigid"){ HapticManager.instance.impact(style: .rigid) }
            Button("Heavy"){ HapticManager.instance.impact(style: .heavy) }

        }
    }
}

struct HapticBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticBootcamp()
    }
}
