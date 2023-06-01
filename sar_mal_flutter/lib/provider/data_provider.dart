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
  bool categoryReturnStatus = false;
  bool recepieReturnStatus = false;
  bool newCategoryAddStatus = false;
  bool newRecepieAddStatus = false;


  // All lDBcategories
  // List<Map<String, dynamic>> _lDBcategories = [];
  // List<Map<String, dynamic>> _lDBrecepies = [];

  List<LocalCategory> _lDBcategories = [];
  List<LocalRecepie> _lDBrecepies = [];
  List<LocalCategory> get lDBcategories => _lDBcategories;
  List<LocalRecepie> get lDBrecepies => _lDBrecepies;

  List cID = [];
  List rID = [];

  // This function is used to fetch all category from the database
  Future<void> getAllLocalDBCategories() async {

    print("This is _getAllLocalDBCategories ");
    _lDBcategories.clear();
    final data = await DatabaseHelper.getCategories();
    // _lDBcategories = data;
    for(int i = 0; i < data.length; i++){
      try{
        _lDBcategories.add(LocalCategory.fromJson(data[i]));
        print("Hii "+i.toString());
      }
      catch(ex){
        print("Himm");
        // rethrow;
      }
    }
    print("Hey "+_lDBcategories.length.toString());
    _lDBcategories.map((e) {
      cID.add(e.categoryID);
    }).toList();
    categoryReturnStatus = true;
    notifyListeners();
  }

  // This function is used to fetch all recepie from the database
  Future<void> getAllLocalDBRecepies() async {

    print("This is _getAllLocalDBRecepies ");
    _lDBrecepies.clear();
    final data = await DatabaseHelper.getRecepies();
    // _lDBrecepies = data;
    for(int i = 0; i < data.length; i++){
      try{
        _lDBrecepies.add(LocalRecepie.fromJson(data[i]));
        print("Hii _recepies  "+i.toString());
        print(_lDBrecepies);
      }
      catch(ex){
        print("Himm _recepies ");
        // rethrow;
      }
    }
    print("Hey "+_lDBrecepies.length.toString());
    _lDBrecepies.map((e) {
      rID.add(e.recepieID);
    }).toList();
    recepieReturnStatus = true;
    notifyListeners();
  }

  bool get MydataReturnStatus {
    return dataReturnStatus;
  }

  void changedataReturnStatus() {
    dataReturnStatus= true;
    notifyListeners();
  }

  bool get MyNewCategoryDataReturnStatus {
    return newCategoryAddStatus;
  }

  void changeNewCategoryDataReturnStatus() {
    newCategoryAddStatus= true;
    notifyListeners();
  }

  bool get MyNewRecepieDataReturnStatus {
    return newRecepieAddStatus;
  }

  void changeNewRecepieDataReturnStatus() {
    newRecepieAddStatus= true;
    notifyListeners();
  }

  Future<bool> getData()async{

    await getAllLocalDBCategories();
    await getAllLocalDBRecepies();
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
          changeNewCategoryDataReturnStatus();
        }
        else{
          dataModel.map((e) async{

            if(!cID.contains(e.categoryID)){
              print(e.categoryName+" is not exit");
              await DatabaseHelper.createCategory(e.categoryID,e.categoryName,e.categoryImgUrl);

            }
            print(" Hello "+e.categoryName);
          }).toList();
          changeNewCategoryDataReturnStatus();
        }

        if(_lDBrecepies.length == 0){
          dataModel.map((e) {
            e.categoryData.map((f)async {
              print(" Hi "+f.title);
              await DatabaseHelper.createRecepie(f.recepieId,f.title,f.description,f.imgUrl,f.categoryId);
              print(f.recepieId.toString()+" is inserted ");
            }).toList();
          }).toList();
          changeNewRecepieDataReturnStatus();
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
          changeNewRecepieDataReturnStatus();
        }

        notifyListeners();
        changedataReturnStatus();
      });
      getAllLocalDBCategories();
      getAllLocalDBRecepies();
      return true;
    }
    catch(ex){
      rethrow;
    }
  }

  List<DataModel> get MyDataModel => dataModel;
  bool get DataReturnStatus => dataReturnStatus;
  bool get AddNewCategoryReturnStatus => newCategoryAddStatus;
  bool get AddNewRecepieReturnStatus => newRecepieAddStatus;



}