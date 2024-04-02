import SwiftUI
import Combine

struct CheckOutView: View {
    @EnvironmentObject var cart: CartViewModel
    let products: [Product]
    let price:Double
    @State private var selectedCurrency = "USD"
    var body: some View {
        VStack {
            Spacer()
            ZStack{
                Color.background.edgesIgnoringSafeArea(.bottom)
                Color.secondaryBackground.opacity(0.3).edgesIgnoringSafeArea(.bottom)
                VStack(alignment:.center, spacing: 0){
                    HStack{
                        Button(action: {withAnimation{cart.showShowcaseSheet.toggle()}}, label: {
                            Image(systemName: "xmark")
                                .imageScale(.medium)
                                .foregroundColor(.darkText)
                        }).padding(8)
                        .background(Color.secondaryBackground)
                        .clipShape(Circle())
                        Spacer()
                    }.padding()
                    Spacer()
                    Text("Please choose a currency")
                    Picker("Please choose a currency", selection: $selectedCurrency) {
                        ForEach((cart.currencyConversation?.quotes.keys.sorted() ?? ["USD"] ), id: \.self) { currency in
                            Text(cart.currencyConversation?.getCurrencyString(key: currency) ?? "").tag(currency)
                                    }
                                }
                    Text("Final Price: \(cart.formatFinalPrice(price: price, currency: selectedCurrency))")
                        .font(.caption)
                    Button(action: {print("Paying ...")}) {
                        Text("Click Here to Pay").bold()
                            .padding()
                            .background(Color.secondaryBackground)
                            .cornerRadius(18)
                    }.padding()
                }.foregroundColor(.darkText)
                Spacer()
            }.cornerRadius(12)
            .frame(height: 300)
        }
        .transition(.move(edge: .bottom))
        .zIndex(20)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(products: Array(Product.sampleProducts[0...2]), price: 500)
    }
}
