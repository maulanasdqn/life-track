import SwiftUI

struct RowCard<Trailing: View>: View {
    let icon: String
    let iconTint: Color
    let title: String
    let subtitle: String
    let trailing: Trailing

    init(icon: String, iconTint: Color, title: String, subtitle: String, @ViewBuilder trailing: () -> Trailing) {
        self.icon = icon
        self.iconTint = iconTint
        self.title = title
        self.subtitle = subtitle
        self.trailing = trailing()
    }

    var body: some View {
        HStack(spacing: 14) {
            IconTile(systemImage: icon, tint: iconTint)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.body.weight(.semibold))
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            trailing
        }
        .padding(14)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

extension RowCard where Trailing == EmptyView {
    init(icon: String, iconTint: Color, title: String, subtitle: String) {
        self.init(icon: icon, iconTint: iconTint, title: title, subtitle: subtitle) { EmptyView() }
    }
}

#Preview {
    RowCard(icon: "checkmark.circle.fill", iconTint: Theme.statusGood, title: "Buy groceries", subtitle: "Completed")
        .padding()
        .background(Theme.background)
}
