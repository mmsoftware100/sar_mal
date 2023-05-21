import 'dart:convert';

import 'package:flutter/material.dart';

import '../constant/util.dart';
import '../database_helper/database_helper.dart';
import '../database_helper/db.dart';
import '../model/data_model.dart';
import 'package:http/http.dart' as http;


class DataProvider extends ChangeNotifier{


  MyDb mydb = new MyDb(); //mydb new object from db.dart
  List<DataModel> dataModel = [];
  bool dataReturnStatus = false;


  // All lDBcategories
  List<Map<String, dynamic>> _lDBcategories = [];
  List<Map<String, dynamic>> _lDBrecepies = [];
  List cID = [];
  List rID = [];

  // This function is used to fetch all category from the database
  Future<void> _getAllLocalDBCategories() async {

    print("This is _getAllLocalDBCategories ");
    final data = await DatabaseHelper.getCategories();
    _lDBcategories = data;
    print("Hey "+_lDBcategories.length.toString());
    _lDBcategories.map((e) {
      cID.add(e['category_id']);
    }).toList();
  }

  // This function is used to fetch all recepie from the database
  Future<void> _getAllLocalDBRecepies() async {

    print("This is _getAllLocalDBRecepies ");
    final data = await DatabaseHelper.getRecepies();
    _lDBrecepies = data;
    print("Hey "+_lDBrecepies.length.toString());
    _lDBrecepies.map((e) {
      rID.add(e['recipes_id']);
    }).toList();
  }

  bool get MydataReturnStatus {
    return dataReturnStatus;
  }

  void changedataReturnStatus() {
    dataReturnStatus= true;
    notifyListeners();
  }

  void getData()async{

    await _getAllLocalDBCategories();
    await _getAllLocalDBRecepies();
    try{
      await ApiService.getDataFromEndPoing().then((success) async {
        print("++++++++++++++++++++++++"+success.toString());
        print("***********************");
        List<dynamic> list = json.decode(success.toString().replaceAll("\n",""));
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

        if(_lDBcategories.length ==0){
          dataModel.map((e) async{

            print(" Hi "+e.categoryName);
            await DatabaseHelper.createCategory(e.categoryID,e.categoryName,e.categoryImgUrl);
            print(e.categoryName+" is inserted ");
          }).toList();
        }
        else{
          dataModel.map((e) async{

            if(!cID.contains(e.categoryID)){
              print(e.categoryName+" is not exit");
              await DatabaseHelper.createCategory(e.categoryID,e.categoryName,e.categoryImgUrl);
            }
            print(" Hello "+e.categoryName);
          }).toList();
        }

        if(_lDBrecepies.length == 0){
          dataModel.map((e) {
            e.categoryData.map((f)async {
              print(" Hi "+f.title);
              await DatabaseHelper.createRecepie(f.recepieId,f.title,f.description,f.imgUrl,f.categoryId);
              print(f.recepieId.toString()+" is inserted ");
            }).toList();
          }).toList();
        }
        else{
          dataModel.map((e) {
            e.categoryData.map((f)async {
              if(!rID.contains(f.recepieId)){
                print(f.recepieId.toString()+" is not exit");
                await DatabaseHelper.createRecepie(f.recepieId, f.title, f.description, f.imgUrl, f.categoryId);
              }
            }).toList();
          }).toList();
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