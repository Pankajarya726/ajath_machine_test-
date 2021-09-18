// To parse this JSON data, do
//
//     final getAssetsResponse = getAssetsResponseFromMap(jsonString);

import 'dart:convert';

class GetAssetsResponse {
  GetAssetsResponse({
    required this.data,
  });

  List<AssetModel> data;

  factory GetAssetsResponse.fromJson(String str) => GetAssetsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAssetsResponse.fromMap(Map<String, dynamic> json) => GetAssetsResponse(
    data: json["data"] == null ? [] : List<AssetModel>.from(json["data"].map((x) => AssetModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class AssetModel {
  AssetModel({
     this.id,
     this.rank,
     this.symbol,
     this.name,
     this.supply,
     this.maxSupply,
     this.marketCapUsd,
     this.volumeUsd24Hr,
     this.priceUsd,
     this.changePercent24Hr,
     this.vwap24Hr,
     this.explorer,
  });

  String? id;
  String? rank;
  String? symbol;
  String? name;
  String? supply;
  String? maxSupply;
  String? marketCapUsd;
  String? volumeUsd24Hr;
  String? priceUsd;
  String? changePercent24Hr;
  String? vwap24Hr;
  String? explorer;

  factory AssetModel.fromJson(String str) => AssetModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssetModel.fromMap(Map<String, dynamic> json) => AssetModel(
    id: json["id"] ?? "",
    rank: json["rank"] ?? "",
    symbol: json["symbol"] ?? "",
    name: json["name"] ?? "",
    supply: json["supply"] ?? '',
    maxSupply: json["maxSupply"] ?? "",
    marketCapUsd: json["marketCapUsd"] ?? "",
    volumeUsd24Hr: json["volumeUsd24Hr"] ?? "",
    priceUsd: json["priceUsd"] ?? "",
    changePercent24Hr: json["changePercent24Hr"] ?? "",
    vwap24Hr: json["vwap24Hr"] ?? "",
    explorer: json["explorer"] ?? "",
  );

  Map<String, dynamic> toMap() => {
    "id": id ?? "",
    "rank": rank ?? "",
    "symbol": symbol ?? "",
    "name": name ?? "",
    "supply": supply ?? "",
    "maxSupply": maxSupply ?? '',
    "marketCapUsd": marketCapUsd ??'',
    "volumeUsd24Hr": volumeUsd24Hr ?? '',
    "priceUsd": priceUsd ?? '',
    "changePercent24Hr": changePercent24Hr ?? '',
    "vwap24Hr": vwap24Hr ?? '',
    "explorer": explorer ?? '',
  };
}
