import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


//color
Color mainColor = Color.fromRGBO(255, 204, 0, 1);

//Decoration
final roundedRectangle12 = RoundedRectangleBorder(
  borderRadius: BorderRadiusDirectional.circular(12),
);

final roundedRectangle4 = RoundedRectangleBorder(
  borderRadius: BorderRadiusDirectional.circular(4),
);

final roundedRectangle40 = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
);

//Style
final headerStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
final titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
final titleStyle2 = TextStyle(fontSize: 16, color: Colors.black45);
final subtitleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
final infoStyle = TextStyle(fontSize: 12, color: Colors.black54);

class URLS {
  static const String dataEndpoint = "https://raw.githubusercontent.com/mmsoftware100/sar_mal/main/sar_mal.json";
}

class ApiService {

  static Future<String> getDataFromEndPoing()async{
    print("This is getDataFromEndPoing Method");

    http.Response r = await http.get(Uri.parse(URLS.dataEndpoint),headers: {"Content-Type": "application/json"});
    print("Status code getDataFromEndPoing is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }
}