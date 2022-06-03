////////////////////Home Model//////////////////////////
class HomeModel{
  late bool status;
  HomeData? data;

  HomeModel.fromJSON(Map<String, dynamic> json){
    status = json['status'];
    data = HomeData.fromJSON(json['data']);
  }
}
class HomeData{
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];
  HomeData.fromJSON(Map<String, dynamic> json){
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJSON(element));
    });
    json['products'].forEach((element){
      products.add(ProductsModel.fromJSON(element));
    });
  }
}
class BannerModel{
  late int id;
  late String image;
  // late String category;
  // late String product;
  BannerModel.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    // category = json['category'];
    // product = json['product'];
  }
}
class ProductsModel{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavourite;
  late bool inCart;
  ProductsModel.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}


////////////////////Fav Model//////////////////////////
// here is a model for favourite items:
// this is a complete model of favorite items.
class FavItems {
  late bool status;
  String? message;
  FavData? data;

  FavItems.fromJSON(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = FavData.fromJSON(json['data']);
  }
}
class FavData {
  late int currentPage;
  List<FavItemsData> data = [];

///////////we don't need these now:)//////////
  int? from;
  int? to;
  late int perPage;
  late int lastPage;
  late int total;
  late String path;
  String? firstPageUrl;
  String? lastPageUrl;
  String? nextPageUrl;
  String? prevPageUrl;
//////////////////////Constructor///////////////////////////
  FavData.fromJSON(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((e){
      data.add(FavItemsData.fromJSON(e));
    });
    from = json['from'];
    to = json['to'];
    perPage = json['per_page'];
    lastPage = json['last_page'];
    total = json['total'];
    path = json['path'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['last_page_url'];
    prevPageUrl = json['next_page_url'];
    firstPageUrl = json['first_page_url'];
  }
}
class FavItemsData {
  late int mainId;
  FavProduct? product;

  FavItemsData.fromJSON(Map<String, dynamic> json){
    mainId = json['id'];
    product = FavProduct.fromJSON(json['product']);
  }
}
class FavProduct {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  FavProduct.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

//save/unSave products
class FavItemsBeta{
  late bool status;
  late String message;
  FavProductsData? data;
  FavItemsBeta.fromJSON(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = FavProductsData.fromJSON(json['data']);
  }
}
class FavProductsData{
  late int id;
  FavProducts? products;

  FavProductsData.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    products = FavProducts.fromJSON(json['product']);
  }
}
class FavProducts{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;

  FavProducts.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}


////////////////////Cart Model//////////////////////////
// here is a model for cart items:
class CartItems {
  late bool status;
  String? message;
  CartData? data;

  CartItems.fromJSON(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = CartData.fromJSON(json['data']);
  }
}
class CartData {
  late dynamic subTotal;
  late dynamic total;
  List<CartItemsData> cartItems = [];

  CartData.fromJSON(Map<String, dynamic> json){
    subTotal = json['sub_total'];
    total = json['total'];
    json['cart_items'].forEach((item){
      cartItems.add(CartItemsData.fromJSON(item));
    });

  }
}
class CartItemsData {
  late int mainId;
  late int quantity;
  CartProduct? product;

  CartItemsData.fromJSON(Map<String, dynamic> json){
    mainId = json['id'];
    quantity = json['quantity'];
    product = CartProduct.fromJSON(json['product']);
  }
}
class CartProduct {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  String? image;
  String? name;
  String? description;
  late bool inFavourite;
  late bool inCart;
  CartProduct.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

//add and delete products to/from cart
class CartItemsBeta{
  late bool status;
  String? message;
  CartProductsData? data;
  CartItemsBeta.fromJSON(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = CartProductsData.fromJSON(json['data']);
  }
}
class CartProductsData{
  late int id;
  late int quantity;
  CartProducts? products;

  CartProductsData.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    quantity = json['quantity'];
    products = CartProducts.fromJSON(json['product']);
  }
}
class CartProducts{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  String? image;
  String? name;
  String? description;

  CartProducts.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
