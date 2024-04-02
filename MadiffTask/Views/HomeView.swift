import SwiftUI

struct HomeView: View {
    @ObservedObject var productsList: ProductsListObject
    @EnvironmentObject var cart: CartViewModel
    @State var pickedCategory: ProductListType = .all
    var body: some View {
        NavigationView{
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                    VStack(alignment: .center) {
                        Text("Hello! \n Enjoy your shopping 🥳")
                            .font(.title).bold()
                            .foregroundColor(.darkText)
                            .multilineTextAlignment(.center)
                            .padding()
                        CustomPicker(choosenCategory: $pickedCategory)
                            .onChange(of: pickedCategory, perform: { value in
                                DispatchQueue.main.async {
                                    productsList.loadProducts(with: pickedCategory)
                                }
                            })
                        if productsList.products != nil {
                            ProductCarousel(products: productsList.featuredProduct)
                                .environmentObject(cart)
                                .padding(.top)
                        } else {
                            LoadingView(isLoading: productsList.isLoading, error: productsList.error){ productsList.loadProducts(with: pickedCategory)
                            }
                        }
                        if productsList.products != nil {
                            ProductList(products: productsList.products!)
                                .environmentObject(cart)
                        } else {
                            LoadingView(isLoading: productsList.isLoading, error: productsList.error){ productsList.loadProducts(with: pickedCategory)
                            }
                        }
                    }
                    .onAppear{
                        DispatchQueue.main.async {
                            productsList.loadProducts(with: pickedCategory)
                        }
                    }
                    Spacer(minLength: 40)
                }
            }.navigationBarTitleDisplayMode(.large)
            .navigationBarItems(
                trailing:
                    TrailingBarItem().environmentObject(cart)
            )
        }.statusBar(hidden: true)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(productsList: ProductsListObject()).environmentObject(CartViewModel())
    }
}

struct TrailingBarItem: View {
    @EnvironmentObject var cart: CartViewModel
    var body: some View {
        NavigationLink(destination: CartView(cartProducts: cart)){
            Image(systemName:"cart")
                .foregroundColor(.darkText)
                .imageScale(.large)
                .overlay(
                    VStack {
                        if cart.cartProductDic.keys.count  > 0 {
                            ZStack {
                                Circle().fill(Color.secondaryBackground)
                                Text("\(cart.cartProductDic.keys.count)")
                                    .font(.caption)
                                    .accessibility(identifier:"cartItemsNumber")
                                    .foregroundColor(.darkText)
                                
                            }
                            Spacer()
                        }
                    }.offset(x: 10, y: -10)
                        .shadow(color: .darkText.opacity(0.2), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                )
        }.accentColor(.darkText)
            .accessibility(identifier: "trailingNavigationBarItem")
    }
}
