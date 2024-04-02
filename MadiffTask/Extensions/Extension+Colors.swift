import SwiftUI

extension Color {    
    /// Change color of the border shadow depending on the user when he click sign in on LoginView
    /// - Parameter condition: an optional bool that will affect the color that is returned
    /// - Returns: a Color
    static func borderColor(condition: Bool?)-> Color{
        switch condition {
        case .some(true):
            return Color.green.opacity(0.8)
        case .some(false):
            return Color.red.opacity(0.8)
        case .none:
            return Color.darkText.opacity(0.2)
        }
    }
}