import Foundation

enum ProductListType: String, CaseIterable {
    
    case all = "All"
    case fruits = "Fruits"
    case dairy = "Dairy"
    case vegetables = "Vegetables"
    
    var description: String {
        switch self {
        case .all: return "/"
        case .fruits: return "/category/Fruits"
        case .dairy: return "/category/Dairy"
        case .vegetables: return "/category/Vegetables"
        }
    }
}

