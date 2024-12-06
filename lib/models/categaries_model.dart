// To parse this JSON data, do
//
//     final categariesModel = categariesModelFromJson(jsonString);

import 'dart:convert';

List<String> categariesModelFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String categariesModelToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
