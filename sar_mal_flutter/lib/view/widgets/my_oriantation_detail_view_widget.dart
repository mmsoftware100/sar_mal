import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sar_mal_flutter/view/widgets/skeleton.dart';

import '../../model/data_model.dart';

class MyOriantationDetailViewWidget extends StatefulWidget {
  LocalRecepie myOriantationlocalRecepie;
  MyOriantationDetailViewWidget({Key? key,required this.myOriantationlocalRecepie}) : super(key: key);

  @override
  State<MyOriantationDetailViewWidget> createState() => _MyOriantationDetailViewWidgetState();
}

class _MyOriantationDetailViewWidgetState extends State<MyOriantationDetailViewWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.myOriantationlocalRecepie.recepieID == 0 ? Container(
      child: Text("..."),
    ) : ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
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
              imageUrl: "${widget.myOriantationlocalRecepie.imgUrl}",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    //colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                  ),
                ),
              ),
              placeholder: (context, url) => Skeleton(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.myOriantationlocalRecepie.title,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "${widget.myOriantationlocalRecepie.createdDate}",
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            widget.myOriantationlocalRecepie.description,
            style: TextStyle(fontSize: 20,),
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }
}
