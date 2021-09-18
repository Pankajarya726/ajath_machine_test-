import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pankaj_ajath_maching_test/main.dart';
import 'package:pankaj_ajath_maching_test/model/get_assets_response.dart';
import 'package:pankaj_ajath_maching_test/ui/assets_detail_screen.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({Key? key}) : super(key: key);

  @override
  _AssetsScreenState createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  StreamController<List<AssetModel>> controller = StreamController();

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  void initState() {
    getAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assets"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              getAssets();
            },
          )
        ],
      ),
      body: StreamBuilder<List<AssetModel>>(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return AssetsDetails(asset: snapshot.data![index]);
                      }));
                    },
                    child: AssetListItem(
                      asset: snapshot.data![index],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  );
                },
                itemCount: snapshot.data!.length);
          }

          return Container();
        },
      ),
    );
  }

  getAssets() async {
    // try {
    Response response = await dio.get("https://api.coincap.io/v2/assets");

    if (response.statusCode == 200) {
      GetAssetsResponse assets =
          GetAssetsResponse.fromJson(response.toString());
      if (assets.data.isNotEmpty) {
//swap a and b to change in sorting
        assets.data
            .sort((a, b) => int.parse(a.rank!).compareTo(int.parse(b.rank!)));
      }

      controller.add(assets.data);
    } else {
      controller.addError(response.statusMessage!);
    }
    // } catch (exception) {
    //
    //   print("exception-->$exception");
    //   controller.addError(exception.toString());
    // }
  }
}

class AssetListItem extends StatelessWidget {
  final AssetModel asset;

  const AssetListItem({required this.asset, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: "Name : ", style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: asset.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ]),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: "Symbol : ", style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: asset.symbol,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ]),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: "Rank : ", style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: asset.rank,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ]),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: "Price USD : ", style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: asset.priceUsd,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ]),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: "Change Percent : ",
                  style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: asset.changePercent24Hr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ]),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
