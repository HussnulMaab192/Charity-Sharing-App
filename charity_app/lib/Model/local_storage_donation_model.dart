import 'package:flutter/foundation.dart';

class LocalDonation {
  int? id;
  String? title;
  String? description;
  String? itemName;
  String? category;
  String? quantity;
  String? pickup;
  Uint8List? attachement;
  String? itemDescription;
  String? date;
  String? status;

  LocalDonation(
      this.id,
      this.title,
      this.description,
      this.itemName,
      this.category,
      this.quantity,
      this.pickup,
      this.attachement,
      this.itemDescription,
      this.date,
      this.status);

  LocalDonation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    pickup = json['pickup'];
    itemName = json['itemName'];
    category = json['category'];
    quantity = json['quantity'];

    attachement = json['attachement'];
    itemDescription = json['itemDescription'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["title"] = title;
    data["description"] = description;
    data['pickup'] = pickup;
    data["itemName"] = itemName;
    data["category"] = category;
    data["quantity"] = quantity;
    data["attachement"] = attachement;
    data["itemDescription"] = itemDescription;
    data["date"] = date;
    data["status"] = status;
    return data;
  }
}
