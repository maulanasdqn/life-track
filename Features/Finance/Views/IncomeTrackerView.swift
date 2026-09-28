import SwiftUI

struct IncomeTrackerView: View {
    @Environment(FinanceStore.self) private var store
    @AppStorage("currencyCode") private var currencyCode: String = "USD"
    @State private var source: String = ""
    @State private var amountText: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Income source", text: $source)
                        .textFieldStyle(.roundedBorder)

                    TextField("Amount", text: $amountText)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)

                    Button("Add Income", action: addIncome)
                        .buttonStyle(PrimaryButtonStyle())
                        .disabled(!isValid)
                }
                .cardStyle()

                if store.incomes.isEmpty {
                    Text("No income tracked")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                } else {
                    VStack(spacing: 12) {
                        ForEach(store.incomes) { income in
                            RowCard(
                                icon: "banknote.fill",
                                iconTint: Theme.statusGood,
                                title: income.source,
                                subtitle: "Income"
                            ) {
                                HStack(spacing: 12) {
                                    Text(income.amount, format: .currency(code: currencyCode))
                                        .font(.subheadline.weight(.semibold))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.8)

                                    Button {
                                        store.deleteIncome(income)
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
                        Text("Total Income")
                            .font(.headline)
                        Spacer()
                        Text(store.totalIncome, format: .currency(code: currencyCode))
                            .font(.headline)
                    }
                    .foregroundStyle(Theme.statusGood)
                    .padding(16)
                    .background(Theme.statusGood.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
            }
            .padding()
        }
        .background(Theme.background)
        .navigationTitle("Income Tracker")
        .tint(Theme.skyBlueStrong)
    }

    private var isValid: Bool {
        !source.trimmingCharacters(in: .whitespaces).isEmpty && Double(amountText) != nil
    }

    private func addIncome() {
        guard let amount = Double(amountText) else { return }
        store.addIncome(source: source, amount: amount)
        source = ""
        amountText = ""
    }
}

#Preview {
    NavigationStack {
        IncomeTrackerView()
            .environment(FinanceStore())
    }
}
