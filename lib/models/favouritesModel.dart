class FavouritesModel {
  bool status;
  dynamic message;
  Data data;
  FavouritesModel.fromJson(Map<String, dynamic> json){
    status=json["status"];
    message= json["message"];
    data=Data.fromJson(json["data"]);
  }
}

class Data {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data.fromJson(Map<String, dynamic> json){
    currentPage=json["current_page"];
    data=List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)));
    firstPageUrl= json["first_page_url"];
    from=json["from"];
    lastPage= json["last_page"];
    lastPageUrl=json["last_page_url"];
    nextPageUrl= json["next_page_url"];
    path= json["path"];
    perPage= json["per_page"];
    prevPageUrl= json["prev_page_url"];
    to=json["to"];
    total=json["total"];
  }
}

class Datum {
  int id;
  Product product;

  Datum.fromJson(Map<String, dynamic> json){
    id = json["id"];
    product = Product.fromJson(json["product"]);
  }

}

class Product {

  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  String image;
  String name;
  String description;

  Product.fromJson(Map<String, dynamic> json){
        id=json["id"];
        price= json["price"];
        oldPrice= json["old_price"];
        discount= json["discount"];
        image= json["image"];
        name=json["name"];
        description= json["description"];
      }
}
