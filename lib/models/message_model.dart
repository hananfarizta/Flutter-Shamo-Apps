import 'package:shamo/models/product_model.dart';

class MessageModel {
  String message;
  int userId;
  String name;
  String userImage;
  bool isFromUser;
  ProductModel product;
  DateTime createdAt;
  DateTime updatedAt;

  MessageModel({
    this.message,
    this.userId,
    this.name,
    this.userImage,
    this.isFromUser,
    this.product,
    this.createdAt,
    this.updatedAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    name = json['name'];
    userImage = json['userImage'];
    isFromUser = json['isFromUser'];
    product = json['product'].isEmpty
        ? UninitializedProductModel()
        : ProductModel.fromJson(json['prduct']);
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
      'name': name,
      'userImage': userImage,
      'isFromUser': isFromUser,
      'product': product is UninitializedProductModel ? {} : product.toJson(),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }
}
