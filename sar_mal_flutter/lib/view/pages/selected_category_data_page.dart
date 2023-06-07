import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../model/data_model.dart';
import '../widgets/trending_item.dart';
import 'detail_page.dart';

class SelectedCategoryPage extends StatefulWidget {

  int categoryID;
  String categoryName;
  List<LocalRecepie> recepieDataModel;
  SelectedCategoryPage({Key? key,required this.categoryID,required this.categoryName,required this.recepieDataModel}) : super(key: key);

  @override
  State<SelectedCategoryPage> createState() => _SelectedCategoryPageState();
}

class _SelectedCategoryPageState extends State<SelectedCategoryPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.recepieDataModel.map((e) {
      print(e.recepieID.toString()+" list ");
      print(e.title.toString()+" title ");
    }).toList();

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.categoryName),
      ),
      body: ListView(
        children: widget.recepieDataModel.map((e) {
          return e.categoryId == widget.categoryID ? InkWell(
              child:  TrendingItem(img: e.imgUrl,title: e.title,description: e.description,rating: "5",) ,
            onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(localRecepie: e)));
            },
          ): Container();
        }).toList(),
      ),
    );
  }
}
