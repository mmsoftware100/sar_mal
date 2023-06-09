import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/data_model.dart';
import '../../provider/data_provider.dart';
import '../widgets/my_oriantation_detail_view_widget.dart';
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

  late LocalRecepie mylocalRecepie;

  recePieChange(LocalRecepie recepie){
    setState(() {
      mylocalRecepie = recepie;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    mylocalRecepie = Provider.of<DataProvider>(context,listen: false).lDBrecepies.where((element) => element.categoryId == widget.categoryID).toList()[0];

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
      body: MediaQuery.of(context).orientation == Orientation.portrait ?  ListView(
        physics: BouncingScrollPhysics(),
        children: widget.recepieDataModel.map((e) {
          return e.categoryId != widget.categoryID ? Container() : InkWell(
              child:  TrendingItem(img: e.imgUrl,title: e.title,description: e.description,rating: "5",cratedDate: e.createdDate,) ,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(localRecepie: e)));
            },
          )  ;
        }).toList(),
      ):
      Row(
          children:[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width *0.3,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: widget.recepieDataModel.map((e) {
                  return e.categoryId != widget.categoryID ? Container() : InkWell(
                    child:  TrendingItem(img: e.imgUrl,title: e.title,description: e.description,rating: "5",cratedDate: e.createdDate,) ,
                    onTap: (){
                      recePieChange(e);
                    },
                  )  ;
                }).toList(),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.7,
                child: MyOriantationDetailViewWidget(myOriantationlocalRecepie: mylocalRecepie,))
            // Text("Hello")
          ]
      ),
    );
  }
}