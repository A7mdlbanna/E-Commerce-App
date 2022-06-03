
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
  List<FavItemsData>? data;

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
    data = json['data'].forEach((e){
      data?.add(FavItemsData.fromJSON(e));
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
  Product? product;

  FavItemsData.fromJSON(Map<String, dynamic> json){
    mainId = json['id'];
    product = Product.fromJSON(json['product']);
  }
}
class Product {
  late int id;
  late int price;
  late int oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  Product.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

// and i made another one that stores the {id, price, oldPrice, discount, image}.
class FavItemsBeta{
  late bool status;
  late String message;
  ProductsData? data;
  FavItemsBeta.fromJSON(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = ProductsData.fromJSON(json['data']);
  }
}
class ProductsData{
  late int id;
  Products? products;

  ProductsData.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    products = Products.fromJSON(json['product']);
  }
}
class Products{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;

  Products.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}