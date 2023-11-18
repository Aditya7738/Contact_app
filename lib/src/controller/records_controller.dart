import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/record.dart';

class RecordsController{
  Future<List<Records>> getData() async {

    //read file get data as string
    String rawData = await rootBundle.loadString("assests/data/records.json");
    List<dynamic> rawDataList = jsonDecode(rawData);
    List<Records> records = rawDataList.map((item) => Records.fromJSON(item)).toList();
    return records;
  }
}