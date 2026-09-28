import Foundation

struct CurrencyOption: Identifiable, Hashable {
    let code: String
    let name: String

    var id: String { code }

    static let all: [CurrencyOption] = [
        CurrencyOption(code: "USD", name: "US Dollar"),
        CurrencyOption(code: "EUR", name: "Euro"),
        CurrencyOption(code: "GBP", name: "British Pound"),
        CurrencyOption(code: "JPY", name: "Japanese Yen"),
        CurrencyOption(code: "IDR", name: "Indonesian Rupiah"),
        CurrencyOption(code: "SGD", name: "Singapore Dollar"),
        CurrencyOption(code: "AUD", name: "Australian Dollar"),
        CurrencyOption(code: "CAD", name: "Canadian Dollar"),
        CurrencyOption(code: "INR", name: "Indian Rupee"),
    ]

    static func name(for code: String) -> String {
        all.first { $0.code == code }?.name ?? code
    }
}
