// To parse this JSON data, do
//
//     final getHistoryResponse = getHistoryResponseFromMap(jsonString);

import 'dart:convert';

class GetHistoryResponse {
  GetHistoryResponse({
    required this.data,
    required this.timestamp,
  });

  List<HistoryModel> data;
  int timestamp;

  factory GetHistoryResponse.fromJson(String str) => GetHistoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetHistoryResponse.fromMap(Map<String, dynamic> json) => GetHistoryResponse(
    data: json["data"] == null ? [] : List<HistoryModel>.from(json["data"].map((x) => HistoryModel.fromMap(x))),
    timestamp: json["timestamp"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
    "timestamp": timestamp ?? 0,
  };
}

class HistoryModel {
  HistoryModel({
    required this.priceUsd,
    required this.time,
    required this.date,
  });

  String priceUsd;
  int time;
  DateTime? date;

  factory HistoryModel.fromJson(String str) => HistoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromMap(Map<String, dynamic> json) => HistoryModel(
    priceUsd: json["priceUsd"] ?? '',
    time: json["time"] ?? 0,
    date: json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toMap() => {
    "priceUsd": priceUsd ?? "",
    "time": time ?? 0,
    "date": date == null ? DateTime.now() : date!.toIso8601String(),
  };
}
