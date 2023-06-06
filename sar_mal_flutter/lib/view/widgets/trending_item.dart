import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sar_mal_flutter/view/widgets/skeleton.dart';

class TrendingItem extends StatefulWidget {
  final String img;
  final String title;
  final String description;
  final String rating;

  TrendingItem({
    Key? key,
    required this.img,
    required this.title,
    required this.description,
    required this.rating,
  }) : super(key: key);

  @override
  _TrendingItemState createState() => _TrendingItemState();
}

class _TrendingItemState extends State<TrendingItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 3.0,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
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
                        imageUrl: "${widget.img}",
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
                          child: Center(child: Skeleton()),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    right: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow[600],
                              size: 10.0,
                            ),
                            Text(
                              " ${widget.rating} ",
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    left: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          " OPEN",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
<<<<<<< Updated upstream
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
=======
                  // child: Expanded(
                  //   child: Text(
                  //     "${widget.title}",
                  //     style: TextStyle(
                  //       fontSize: 20.0,
                  //       fontWeight: FontWeight.w800,
                  //     ),
                  //     textAlign: TextAlign.left,
                  //     overflow: TextOverflow.clip,
                  //   ),
                  // ),
                  child:Expanded(
                    child: RichText(
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                      //text: '${widget.title}',
                      style: DefaultTextStyle.of(context).style,

                      children: <TextSpan>[
                        TextSpan(text: "${widget.title}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        //TextSpan(text: 'Super long unbolded text here'),
                      ],
                    ),
                ),
                  )
>>>>>>> Stashed changes
                ),
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${widget.description}",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}