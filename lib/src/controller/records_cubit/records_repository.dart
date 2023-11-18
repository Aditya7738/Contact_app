import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class RecordsRepository{
  //data fetching
  Future<List<dynamic>?> getData() async {
    try{
      String rawData = await rootBundle.loadString("assests/data/records.json");
      List<dynamic> rawDataList = jsonDecode(rawData);
      return rawDataList;
    }catch(ex){
      return null;
    }
    //read file get data as string



  }
}