//
//  CustomTabBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 16/11/2023.
//

import SwiftUI

struct CustomTabBootcamp: View {
    @State var tabs: [TabBarItem] = [.home, .favourites, .profile, .settings]
    @State var selectedTab: TabBarItem = .home
    
    var body: some View {
        CustomTabView(tabs: $tabs, selection: $selectedTab) {
            Color.red
                .tabItem(tab: .home, selection: $selectedTab)
            Color.green
                .tabItem(tab: .favourites, selection: $selectedTab)
            Color.blue
                .tabItem(tab: .profile, selection: $selectedTab)
            Color.orange
                .tabItem(tab: .settings, selection: $selectedTab)
        }
    }
}

struct CustomTabView<Content:View>: View {
    
    @Binding var tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    let content: Content
    
    init(tabs: Binding<[TabBarItem]>, selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._tabs = tabs
        self._selection = selection
        self.content = content()
    }
    
    var body: some View{
        ZStack(alignment: .bottom){
            content.ignoresSafeArea()
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
        }
        .onPreferenceChange(TabBarItemPreferenceKey.self) { value in
            self.tabs = tabs
        }
    }
}

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    
    var body: some View{
        tabBarView
            .onChange(of: selection) { value in
                withAnimation(.easeInOut) {
                    localSelection = value
                }
            }
    }
}

extension CustomTabBarView {
    private var tabBarView: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab)
                    .onTapGesture { switchToTab(tab: tab) }
            }
        }
        .padding(6)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5.0)
        .padding(.horizontal)
    }
}

extension CustomTabBarView {
    private func tabView(_ tab: TabBarItem) -> some View{
        VStack{
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.label)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack{
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(tab.color.opacity(0.1))
                        .matchedGeometryEffect(id: "tab_background", in: namespace)
                }
            }
        )
        .cornerRadius(4)
    }
    
    private func switchToTab(tab: TabBarItem){
        selection = tab
    }
}

extension View {
    func tabItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        self.modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}

struct TabBarItemViewModifier: ViewModifier {
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemPreferenceKey.self, value: [tab])
    }
}

struct TabBarItemPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

enum TabBarItem: String, Hashable{
    case home, favourites, profile, settings
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favourites: return "heart"
        case .profile: return "person"
        case .settings: return "gearshape.fill"
        }
    }
    
    var label: String {
        return self.rawValue.capitalized
    }
    
    var color: Color {
        switch self {
        case .home: return .red
        case .favourites: return .green
        case .profile: return .blue
        case .settings: return .orange
        }
    }
}

struct CustomTabBootcamp_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [.home, .favourites, .profile, .settings]
    
    static var previews: some View {
        CustomTabBootcamp()
        /*
         CustomTabView(tabs: tabs, selection: .constant(tabs.first!)){
         Color.red
         }
         */
        /*
         VStack{
         Spacer()
         CustomTabBar(tabs: tabs, selection: .constant(tabs.first!))
         }
         */
    }
}
