import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pankaj_ajath_maching_test/main.dart';
import 'package:pankaj_ajath_maching_test/model/get_assets_response.dart';
import 'package:pankaj_ajath_maching_test/model/get_history_response.dart';
import 'package:pankaj_ajath_maching_test/ui/assets_screen.dart';

class AssetsDetails extends StatefulWidget {
  final AssetModel asset;

  const AssetsDetails({required this.asset, Key? key}) : super(key: key);

  @override
  _AssetsDetailsState createState() => _AssetsDetailsState();
}

class _AssetsDetailsState extends State<AssetsDetails> {
  StreamController<List<HistoryModel>> controller = StreamController();

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.asset.name!.toUpperCase()),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AssetListItem(asset: widget.asset),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("History : "),
            ),
            StreamBuilder<List<HistoryModel>>(
              stream: controller.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                        // shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return HistoryItemList(
                              history: snapshot.data![index]);
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1,
                            color: Colors.grey.shade300,
                          );
                        },
                        itemCount: snapshot.data!.length),
                  );
                }

                return Container();
              },
            )
          ],
        ));
  }

  getHistory() async {
    try {
      Response response = await dio.get(
          "https://api.coincap.io/v2/assets/${widget.asset.id}/history?interval=d1");

      if (response.statusCode == 200) {
        GetHistoryResponse histories =
            GetHistoryResponse.fromJson(response.toString());

        controller.add(histories.data);
      } else {
        controller.addError(response.statusMessage!);
      }
    } catch (exception) {
      print("exception-->$exception");
      controller.addError(exception.toString());
    }
  }
}

class HistoryItemList extends StatelessWidget {
  final HistoryModel history;

  const HistoryItemList({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String formatteddate = DateFormat.yMd().format(history.date!);
    print(formatteddate);

    var millis = history.time;
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);

// 12 Hour format:
    var time = DateFormat('hh:mm a').format(dt); // 12/31/2000, 10:00 PM



    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: "Price Usd : ", style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: history.priceUsd,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ]),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: "time : ", style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: time.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ]),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: "Date : ", style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: formatteddate,
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
