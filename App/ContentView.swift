import SwiftUI

struct ContentView: View {
    @State private var financeStore = FinanceStore()

    var body: some View {
        TabView {
            FinanceView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                }

            AnalyticsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
        .environment(financeStore)
        .tint(Theme.skyBlueStrong)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
