import SwiftUI

struct AnalyticsView: View {
    @Environment(FinanceStore.self) private var financeStore
    @AppStorage("currencyCode") private var currencyCode: String = "USD"

    private var netBalance: Double {
        financeStore.totalIncome - financeStore.totalDebt
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        StatTileView(
                            icon: "arrow.down.circle.fill",
                            tint: Theme.statusGood,
                            label: "Income",
                            value: financeStore.totalIncome.formatted(.currency(code: currencyCode))
                        )
                        StatTileView(
                            icon: "arrow.up.circle.fill",
                            tint: Theme.statusSerious,
                            label: "Debt",
                            value: financeStore.totalDebt.formatted(.currency(code: currencyCode))
                        )
                    }

                    StatTileView(
                        icon: netBalance >= 0 ? "checkmark.seal.fill" : "exclamationmark.triangle.fill",
                        tint: netBalance >= 0 ? Theme.statusGood : Theme.statusSerious,
                        label: "Net Balance",
                        value: netBalance.formatted(.currency(code: currencyCode))
                    )
                    .frame(maxWidth: .infinity)
                }
                .padding()
            }
            .background(Theme.background)
            .navigationTitle("Analytics")
        }
        .tint(Theme.skyBlueStrong)
    }
}

#Preview {
    AnalyticsView()
        .environment(FinanceStore())
}
