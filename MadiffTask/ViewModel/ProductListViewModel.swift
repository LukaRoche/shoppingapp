import Foundation

class ProductsListObject: ObservableObject {
    @Published var products: [Product]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    var featuredProduct : [Product] {
        var fProducts: [Product] = []
        if let products = self.products  {
            fProducts = products[0...products.count-1].shuffled()
        }
        return fProducts
    }
        
    init(){}
    
    /// Call the api services to get the product needed. For task needs, we provided a mocked data from json
    /// - Parameter url: category of products
    func loadProducts(with url: ProductListType){
        self.products = Product.sampleProducts.filter({ item in
            if url == .all { return true }
            return item.category == url.rawValue
        })
    }
}
