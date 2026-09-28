import SwiftUI

struct SettingsView: View {
    @Environment(FinanceStore.self) private var financeStore
    @AppStorage("currencyCode") private var currencyCode: String = "USD"

    @State private var confirmingClearFinance = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Preferences")
                            .font(.headline)

                        RowCard(
                            icon: "dollarsign.circle.fill",
                            iconTint: Theme.skyBlueStrong,
                            title: "Currency",
                            subtitle: CurrencyOption.name(for: currencyCode)
                        ) {
                            Picker("Currency", selection: $currencyCode) {
                                ForEach(CurrencyOption.all) { option in
                                    Text(option.code).tag(option.code)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(Theme.skyBlueStrong)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Data")
                            .font(.headline)

                        RowCard(
                            icon: "creditcard.fill",
                            iconTint: Theme.statusSerious,
                            title: "Finance",
                            subtitle: "\(financeStore.debts.count) debts, \(financeStore.incomes.count) income"
                        ) {
                            Button("Clear") {
                                confirmingClearFinance = true
                            }
                            .buttonStyle(.borderless)
                            .foregroundStyle(Theme.statusSerious)
                            .disabled(financeStore.debts.isEmpty && financeStore.incomes.isEmpty)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("About")
                            .font(.headline)

                        RowCard(
                            icon: "info.circle.fill",
                            iconTint: Theme.skyBlueStrong,
                            title: "Version",
                            subtitle: appVersion
                        )
                    }
                }
                .padding()
            }
            .background(Theme.background)
            .navigationTitle("Settings")
        }
        .tint(Theme.skyBlueStrong)
        .confirmationDialog(
            "Clear all finance data? This cannot be undone.",
            isPresented: $confirmingClearFinance,
            titleVisibility: .visible
        ) {
            Button("Clear Finance Data", role: .destructive) {
                financeStore.debts.removeAll()
                financeStore.incomes.removeAll()
            }
        }
    }

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
}

#Preview {
    SettingsView()
        .environment(FinanceStore())
}
