import 'dart:convert';

import 'package:flutter/material.dart';

import '../constant/util.dart';
import '../model/data_model.dart';
import 'package:http/http.dart' as http;


class DataProvider extends ChangeNotifier{

  List<DataModel> dataModel = [];
  bool dataReturnStatus = false;

  bool get MydataReturnStatus {
    return dataReturnStatus;
  }

  void changedataReturnStatus() {
    dataReturnStatus= true;
    notifyListeners();
  }

  void getData()async{


    try{
      await ApiService.getDataFromEndPoing().then((success) {
        print("++++++++++++++++++++++++"+success.toString());
        print("***********************");
        List<dynamic> list = json.decode(success);
        print("getDataFromEndPoing data is ** "+list.toString());
        dataModel.clear();
        for(int i = 0; i < list.length; i++){
          try{
            dataModel.add(DataModel.fromJson(list[i]));
          }
          catch(ex){
            rethrow;
          }
        }
        notifyListeners();
        changedataReturnStatus();
      });
    }
    catch(ex){
      rethrow;
    }
  }

  List<DataModel> get MyDataModel => dataModel;
  bool get DataReturnStatus => dataReturnStatus;

}