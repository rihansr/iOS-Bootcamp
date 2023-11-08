import SwiftUI

protocol ColorTheme: PrimaryColorTheme, SecondaryColorTheme {}

protocol PrimaryColorTheme {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

protocol SecondaryColorTheme {
    var surface: Color { get }
    var action: Color { get }
}

struct LightColorTheme: ColorTheme {
    var primary: Color = .yellow
    var secondary: Color = .black
    var tertiary: Color = .white
    var surface: Color = .purple
    var action: Color = .green
}

struct DarkColorTheme: ColorTheme {
    var primary: Color = .blue
    var secondary: Color = .white
    var tertiary: Color = .black
    var surface: Color = .red
    var action: Color = .gray
}

struct ProtocolsBootcamp: View {
    
    @State var theme: ColorTheme
    
    var body: some View {
        ZStack{
            theme.tertiary.ignoresSafeArea()
            Text("Click Me!!")
                .font(.headline)
                .foregroundColor(theme.secondary)
                .padding(.all)
                .background(theme.primary)
                .cornerRadius(6)
                .onTapGesture {
                    theme = DarkColorTheme()
                }
        }
    }
}

struct ProtocolsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolsBootcamp(theme: LightColorTheme())
    }
}
