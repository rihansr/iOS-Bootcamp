//
//  AccessibilityColorBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 06/11/2023.
//
// Xcode -> Open Developer Tool -> Accessibility Inspector
// Window -> Show COlor Contrast Calculator
import SwiftUI

struct AccessibilityColorBootcamp: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityInvertColors) var invertColors
    
    var body: some View {
        NavigationStack{
            ZStack{
                (reduceTransparency ? Color.black: Color.black.opacity(0.5)).ignoresSafeArea()
                VStack(alignment: .center, spacing: 16) {
                    Button("Button 1") {}
                    .foregroundColor(colorSchemeContrast == .increased ? .white : .primary)
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
                    Button("Button 2") {}
                        .foregroundColor(invertColors ? .black : .white)
                    .buttonStyle(.borderedProminent)
                    .tint(invertColors ? .orange : .purple)
                    
                    Button("Button 3") {}
                    .foregroundColor(.white)
                    .foregroundColor(.primary)
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    Button("Button 4") {}
                        .foregroundColor(differentiateWithoutColor ? .white : .black)
                    .buttonStyle(.borderedProminent)
                    .tint(differentiateWithoutColor ? .black : .orange)
                }
                .font(.largeTitle)
            }
            .navigationTitle("Accessibility Color")
        }
    }
}

struct AccessibilityColorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityColorBootcamp()
    }
}
