import Foundation

struct CurrencyConversion: Codable {
    var success: Bool
    var timestamp: Int
    var source: String
    var quotes: [String : Double]
}

extension CurrencyConversion {
    func getCurrencyString(key: String) -> String {
        if key == "USD" {
            return key
        } else {
            return key.replacingOccurrences(of: "USD", with: "")
        }
    }
}
