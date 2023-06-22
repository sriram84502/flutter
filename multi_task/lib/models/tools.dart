import 'package:flutter/material.dart';

class Tools {
  Tools({
    required this.image,
    required this.name,
    required this.location,
  });
  late String image;
  late String name;
  late Widget location;

  Tools.fromJson(Map<String, dynamic> json){
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    location = json['location'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['location'] = location;
    return data;
  }
}