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
    title = json['title'].toString();
    description = json['description'].toString();
    pickup = json['pickup'].toString();
    itemName = json['itemName'].toString();
    category = json['category'].toString();
    quantity = json['quantity'].toString();

    attachement = json['attachement'];
    itemDescription = json['itemDescription'].toString();
    date = json['date'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
