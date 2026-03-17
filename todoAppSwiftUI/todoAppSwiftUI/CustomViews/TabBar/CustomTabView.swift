import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab = 0
    

    let brandColor = Color(red: 36/255, green: 161/255, blue: 156/255)
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(.home)
                    Text("Home")
                }
            .tag(0)
            NewTodoView(selectedTab: $selectedTab)
            .tabItem { Image(.paperPlus)
                Text("New Todo")}
            .tag(1)
            
            SettingsView()
                .tabItem {
                    Image(.settings)
                    Text("Settings")
                }
                .tag(2)
        }
        .tint(brandColor)
    }
}
