import SwiftUI

struct MainView: View {
    @StateObject var products = ProductsListObject()
    @StateObject var cartItems = CartViewModel()
    var body: some View {
        TabView{
            HomeView(productsList: products).environmentObject(cartItems)
                .tabItem {
                    Image(systemName:"house")
                    Text("Home")
                }
        }
        .zIndex(10)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
