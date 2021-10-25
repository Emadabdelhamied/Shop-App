class Categories {
  bool status;
  CategoryDataModel data;
  Categories.fromJson(Map<String, dynamic> json){
    status=json['status'];
    data=CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
  int currentPage;
  List<CategoryData> data = [];
  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(CategoryData.fromJson(element));
    });
  }
}

class CategoryData {
  int id;
  String name;
  String image;
  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
