import 'Comments.dart';

class Products {
  int? id;
  String? title;
  String? description;
  String? image;
  int? comments;
  double? rate;
  String? createdAt;
  String? updatedAt;
  List<Comments>? commentsText;

  Products(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.comments,
        this.rate,
        this.createdAt,
        this.updatedAt,
        this.commentsText
      });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];

    if (json['comments'] != null) {
      comments = json['comments'];
    }
    else
    {
      comments=0;
    }
    if (json['rate'] != null) {
      rate = json['rate'].toDouble();
    }
    else
    {
      rate=0;
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }
  Products.fromJson2(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['rate'] != null) {
      rate = json['rate'].toDouble();
    }
    else
      {
        rate=0;
      }

    if (json['comments'] != null) {
      commentsText = [];
      json['comments'].forEach((v) {
        commentsText!.add(new Comments.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['comments'] = this.comments;
    data['rate'] = this.rate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.comments != null) {
      data['comments'] = this.commentsText!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}