import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../model/data_model.dart';

class DetailPage extends StatefulWidget {
  LocalRecepie localRecepie;
  DetailPage({Key? key,required this.localRecepie}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.localRecepie.title),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              // child: Image.asset(
              //   "${widget.img}",
              //   fit: BoxFit.cover,
              // ),
              child: CachedNetworkImage(
                imageUrl: "${widget.localRecepie.imgUrl}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      //colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                    ),
                  ),
                ),
                placeholder: (context, url) => Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.localRecepie.title,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.localRecepie.description,
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
