import SwiftUI

struct FinanceView: View {
    @Environment(FinanceStore.self) private var store
    @AppStorage("currencyCode") private var currencyCode: String = "USD"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        StatTileView(
                            icon: "arrow.down.circle.fill",
                            tint: Theme.statusGood,
                            label: "Income",
                            value: store.totalIncome.formatted(.currency(code: currencyCode))
                        )
                        StatTileView(
                            icon: "arrow.up.circle.fill",
                            tint: Theme.statusSerious,
                            label: "Debt",
                            value: store.totalDebt.formatted(.currency(code: currencyCode))
                        )
                    }

                    NavigationLink {
                        DebtTrackerView()
                    } label: {
                        RowCard(
                            icon: "creditcard.fill",
                            iconTint: Theme.statusSerious,
                            title: "Debt Tracker",
                            subtitle: "\(store.debts.count) debts tracked"
                        ) {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        IncomeTrackerView()
                    } label: {
                        RowCard(
                            icon: "banknote.fill",
                            iconTint: Theme.statusGood,
                            title: "Income Tracker",
                            subtitle: "\(store.incomes.count) sources tracked"
                        ) {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .padding()
            }
            .background(Theme.background)
            .navigationTitle("Finance")
        }
        .tint(Theme.skyBlueStrong)
    }
}

#Preview {
    FinanceView()
        .environment(FinanceStore())
}
