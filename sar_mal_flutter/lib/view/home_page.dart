import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../constant/util.dart';
import '../model/data_model.dart';
import '../provider/data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DataProvider>(context,listen: false).getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("စားမယ်"),
      ),
      body:Provider.of<DataProvider>(context,listen: true).DataReturnStatus == false ? ListView(
        children: [

        ],
      ):
      // ListView(
      //   children: Provider.of<DataProvider>(context,listen: false).MyDataModel.map((e) {
      //     return  Container(
      //       child: Card(
      //         shape: roundedRectangle12,
      //         child: Stack(
      //           children: <Widget>[
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.stretch,
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: <Widget>[
      //                 Container(
      //                   height: MediaQuery.of(context).size.width / 2.5,
      //                   child: ClipRRect(
      //                     borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      //                     child: Image.network(
      //                       e.categoryImgUrl,
      //                       fit: BoxFit.cover,
      //                     ),
      //                   ),
      //                 ),
      //                 // buildTitle(),
      //                 // buildRating(),
      //                 // buildPriceInfo(),
      //               ],
      //             ),
      //             Align(
      //               alignment: Alignment.topRight,
      //               child: Container(
      //                 padding: EdgeInsets.all(4),
      //                 decoration: BoxDecoration(
      //                   color: mainColor,
      //                   borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
      //                 ),
      //                 child: Text(e.categoryName),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     );
      //   }).toList(),
      // ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
            crossAxisCount: 2,
            children: Provider.of<DataProvider>(context,listen: false).MyDataModel.map(
                    (e) => Container(
                      height: MediaQuery.of(context).size.height/3,
                      child: Card(
                        shape: roundedRectangle12,
                        child: Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                buildImage(e),
                                // buildTitle(e),
                                // buildRating(e),
                                // buildPriceInfo(),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                                ),
                                child: Text(e.categoryName),
                              ),
                            )
                          ],
                        ),
                      ),
                    )).toList()
        ),
      )
    );
  }

  Widget buildImage(DataModel food) {
    return Container(
      height: MediaQuery.of(context).size.width / 2.5,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        child: Image.network(
          food.categoryImgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildTitle(DataModel food) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            food.categoryName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: titleStyle,
          ),
          Text(
            food.categoryName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: infoStyle,
          ),
        ],
      ),
    );
  }

  Widget buildRating(DataModel food) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RatingBar(
            initialRating: 5.0,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 14,
            unratedColor: Colors.black,
            itemPadding: EdgeInsets.only(right: 4.0),
            ignoreGestures: true,
            itemBuilder: (context, index) => Icon(Icons.star, color: mainColor),
            onRatingUpdate: (rating) {},
          ),
          Text('5'),
        ],
      ),
    );
  }

  Widget buildPriceInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '\$ ${100}',
            style: titleStyle,
          ),
          Card(
            margin: EdgeInsets.only(right: 0),
            shape: roundedRectangle4,
            color: mainColor,
            child: InkWell(
              onTap: (){},
              splashColor: Colors.white70,
              customBorder: roundedRectangle4,
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
