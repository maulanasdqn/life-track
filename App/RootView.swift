import SwiftUI

struct RootView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            if isActive {
                ContentView()
            } else {
                SplashView()
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation(.easeOut(duration: 0.4)) {
                isActive = true
            }
        }
    }
}

#Preview {
    RootView()
}
