import SwiftUI

struct SplashView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Theme.skyBlueStrong
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "dollarsign.circle.fill")
                    .font(.system(size: 72, weight: .semibold))
                    .symbolRenderingMode(.monochrome)
                    .foregroundStyle(.white)

                Text("LifeTrack")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Text("Take control of your finances")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85))
            }
            .scaleEffect(isAnimating ? 1 : 0.85)
            .opacity(isAnimating ? 1 : 0)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                isAnimating = true
            }
        }
    }
}

#Preview {
    SplashView()
}
