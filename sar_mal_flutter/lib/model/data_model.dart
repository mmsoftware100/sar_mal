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
    required this.recepieId,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.categoryId,
  });
  late final int recepieId;
  late final String title;
  late final String description;
  late final String imgUrl;
  late final int categoryId;

  CategoryData.fromJson(Map<String, dynamic> json){
    recepieId = json['recipes_id'];
    title = json['title'].toString();
    description = json['description'].toString();
    imgUrl = json['img_url'].toString();
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['recipes_id'] = recepieId;
    _data['title'] = title;
    _data['description'] = description;
    _data['img_url'] = imgUrl;
    _data['category_id'] = categoryId;
    return _data;
  }
}

class LocalCategory {
  LocalCategory({
    required this.categoryID,
    required this.categoryName,
    required this.categoryImgUrl,
  });
  late final int categoryID;
  late final String categoryName;
  late final String categoryImgUrl;

  LocalCategory.fromJson(Map<String, dynamic> json){
    categoryID = json['category_id'];
    categoryName = json['category_name'].toString();
    categoryImgUrl = json['category_img_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category_id'] = categoryID;
    _data['category_name'] = categoryName;
    _data['category_img_url'] = categoryImgUrl;
    return _data;
  }
}

class LocalRecepie {
  LocalRecepie({
    required this.recepieID,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.categoryId,
  });
  late final int recepieID;
  late final String title;
  late final String description;
  late final String imgUrl;
  late final int categoryId;

  LocalRecepie.fromJson(Map<String, dynamic> json){
    recepieID = json['recipes_id'];
    title = json['recipe_title'].toString();
    description = json['recipe_description'].toString();
    imgUrl = json['recipe_img_url'].toString();
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['recipes_id'] = recepieID;
    _data['recipe_title'] = title;
    _data['recipe_description'] = description;
    _data['recipe_img_url'] = imgUrl;
    _data['category_id'] = categoryId;
    return _data;
  }
}
