import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartProduct: [Product] = []
    @Published var cartProductDic: [Product: Int] = [:]
    @Published var totalPrice: Double = 0
    @Published var showShowcaseSheet: Bool = false
    @Published var currencyConversation: CurrencyConversion?

    /// adding a product with the quantity on our cart
    /// - Parameters:
    ///   - addedProduct: product we want to add
    ///   - quantity: quantity of product we want to add
    func addToCart(addedProduct: Product, quantity: Int){
        let products = cartProductDic.map({$0.key})
        // if we don't have any product we just create it with our quantity and leave the func
        if products.isEmpty {
            withAnimation{
                cartProductDic[addedProduct] = quantity
            }
            return
        }
        for product in products {
            // if we already have the product we check our product and add the quantity
            if addedProduct.id == product.id {
                withAnimation{
                    cartProductDic[product]! += quantity
                }
            } else {
                // if we have products but dont have this one, we create it with the quantity
                if !products.contains(where: {$0.id == addedProduct.id}){
                    withAnimation{
                        cartProductDic[addedProduct] = quantity
                    }
                }
            }
        }
    }
    func changeQuantity(product: Product,quantity: Int){
        cartProductDic[product] = quantity
    }
    
    func calculateTotalPrice(){
        getCurrencies()
        var totalprice: Double = 0
        for (product,quantity) in cartProductDic {
            totalprice += product.price * Double(quantity)
        }
        withAnimation{
            totalPrice = totalprice
        }
    }
    func removeFromCart(toRemove: Product){
        cartProductDic.removeValue(forKey: toRemove)
    }
    
    func getCurrencies() {
        var response: CurrencyConversion? = try? Bundle.main.loadAndDecodeJSON(filename: "currencies")
        response?.quotes.updateValue(1.0, forKey: "USD")
        self.currencyConversation = response
    }
    
    func formatFinalPrice(price: Double, currency: String) -> String {
        guard let chosenCurrency = currencyConversation?.getCurrencyString(key: currency) else { return "" }
        guard let multiplier = currencyConversation?.quotes[currency] else { return "" }
        let finalPrice = (price * multiplier).format(f: ".02")
        return "\(finalPrice) \(chosenCurrency)"
    }
}
