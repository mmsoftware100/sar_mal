class DataModel {
  DataModel({
    required this.categoryID,
    required this.categoryName,
    required this.categoryImgUrl,
    required this.categoryData,
  });
  late final int categoryID;
  late final String categoryName;
  late final String categoryImgUrl;
  late final List<CategoryData> categoryData;

  DataModel.fromJson(Map<String, dynamic> json){
    categoryID = json['category_id'];
    categoryName = json['category_name'].toString();
    categoryImgUrl = json['category_img_url'].toString();
    categoryData = List.from(json['category_data']).map((e)=>CategoryData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category_id'] = categoryID;
    _data['category_name'] = categoryName;
    _data['category_img_url'] = categoryImgUrl;
    _data['category_data'] = categoryData.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CategoryData {
  CategoryData({
    required this.title,
    required this.description,
    required this.imgUrl,
  });
  late final String title;
  late final String description;
  late final String imgUrl;

  CategoryData.fromJson(Map<String, dynamic> json){
    title = json['title'].toString();
    description = json['description'].toString();
    imgUrl = json['img_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['description'] = description;
    _data['img_url'] = imgUrl;
    return _data;
  }
}