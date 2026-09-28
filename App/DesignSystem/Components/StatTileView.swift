import SwiftUI

struct StatTileView: View {
    let icon: String
    let tint: Color
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            IconTile(systemImage: icon, tint: tint)

            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title2.bold())
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}

#Preview {
    HStack {
        StatTileView(icon: "arrow.down.circle.fill", tint: Theme.statusGood, label: "Income", value: "$1,200")
        StatTileView(icon: "arrow.up.circle.fill", tint: Theme.statusSerious, label: "Debt", value: "$400")
    }
    .padding()
    .background(Theme.background)
}
