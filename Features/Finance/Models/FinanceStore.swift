import Observation
import SwiftUI

struct DebtItem: Identifiable {
    let id = UUID()
    var name: String
    var amount: Double
}

struct IncomeItem: Identifiable {
    let id = UUID()
    var source: String
    var amount: Double
}

@Observable
final class FinanceStore {
    var debts: [DebtItem] = []
    var incomes: [IncomeItem] = []

    var totalDebt: Double {
        debts.reduce(0) { $0 + $1.amount }
    }

    var totalIncome: Double {
        incomes.reduce(0) { $0 + $1.amount }
    }

    func addDebt(name: String, amount: Double) {
        let trimmed = name.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty, amount > 0 else { return }
        debts.append(DebtItem(name: trimmed, amount: amount))
    }

    func deleteDebt(_ debt: DebtItem) {
        debts.removeAll { $0.id == debt.id }
    }

    func addIncome(source: String, amount: Double) {
        let trimmed = source.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty, amount > 0 else { return }
        incomes.append(IncomeItem(source: trimmed, amount: amount))
    }

    func deleteIncome(_ income: IncomeItem) {
        incomes.removeAll { $0.id == income.id }
    }
}
