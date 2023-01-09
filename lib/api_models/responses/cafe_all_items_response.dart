class CafeItemResponse {
  List<Items>? items;

  CafeItemResponse({this.items});

  CafeItemResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? sId;
  String? itemName;
  int? itemPrice;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Items(
      {this.sId,
        this.itemName,
        this.itemPrice,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemName = json['itemName'];
    itemPrice = json['itemPrice'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['itemName'] = this.itemName;
    data['itemPrice'] = this.itemPrice;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}