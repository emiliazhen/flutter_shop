class CategoryLargeModel {
  String mallCategoryId; // 类别编号
  String mallCategoryName; // 类别名称
  Null comments; // 列表描述
  String image; // 类别图片
  List<dynamic> bxMallSubDto; // 小类列表
  
  CategoryLargeModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.comments,
    this.image,
    this.bxMallSubDto
  });

  factory CategoryLargeModel.fromJson(dynamic json){
    return CategoryLargeModel(
      mallCategoryId:json['mallCategoryId'],
      mallCategoryName:json['mallCategoryName'],
      comments:json['comments'],
      image:json['image'],
      bxMallSubDto:json['bxMallSubDto']
    );
  }
}

class CategoryListModel {
  List<CategoryLargeModel> data;
  CategoryListModel(this.data);

  factory CategoryListModel.fromJson(List json){
    return CategoryListModel(
      json.map((i) => CategoryLargeModel.fromJson((i))).toList()
    );
  }
}