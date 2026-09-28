import SwiftUI

struct DebtTrackerView: View {
    @Environment(FinanceStore.self) private var store
    @AppStorage("currencyCode") private var currencyCode: String = "USD"
    @State private var name: String = ""
    @State private var amountText: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Debt name", text: $name)
                        .textFieldStyle(.roundedBorder)

                    TextField("Amount", text: $amountText)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)

                    Button("Add Debt", action: addDebt)
                        .buttonStyle(PrimaryButtonStyle())
                        .disabled(!isValid)
                }
                .cardStyle()

                if store.debts.isEmpty {
                    Text("No debts tracked")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                } else {
                    VStack(spacing: 12) {
                        ForEach(store.debts) { debt in
                            RowCard(
                                icon: "creditcard.fill",
                                iconTint: Theme.statusSerious,
                                title: debt.name,
                                subtitle: "Debt"
                            ) {
                                HStack(spacing: 12) {
                                    Text(debt.amount, format: .currency(code: currencyCode))
                                        .font(.subheadline.weight(.semibold))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.8)

                                    Button {
                                        store.deleteDebt(debt)
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundStyle(.secondary)
                                    }
                                    .buttonStyle(.borderless)
                                }
                            }
                        }
                    }

                    HStack {
                        Text("Total Debt")
                            .font(.headline)
                        Spacer()
                        Text(store.totalDebt, format: .currency(code: currencyCode))
                            .font(.headline)
                    }
                    .foregroundStyle(Theme.statusSerious)
                    .padding(16)
                    .background(Theme.statusSerious.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
            }
            .padding()
        }
        .background(Theme.background)
        .navigationTitle("Debt Tracker")
        .tint(Theme.skyBlueStrong)
    }

    private var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && Double(amountText) != nil
    }

    private func addDebt() {
        guard let amount = Double(amountText) else { return }
        store.addDebt(name: name, amount: amount)
        name = ""
        amountText = ""
    }
}

#Preview {
    NavigationStack {
        DebtTrackerView()
            .environment(FinanceStore())
    }
}
