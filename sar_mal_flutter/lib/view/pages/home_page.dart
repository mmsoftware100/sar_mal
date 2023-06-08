import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sar_mal_flutter/view/pages/selected_category_data_page.dart';

import '../../constant/util.dart';
import '../../database_helper/database_helper.dart';
import '../../model/data_model.dart';
import '../../provider/data_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../widgets/skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final FirebaseMessaging _messaging;
  late int _totalNotifications;

   List<Color> _kDefaultRainbowColors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

   bool _isLoading = true;

  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel_martin', // id
      'High Importance Notifications Martin', // title
      importance: Importance.high,
      playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("_firebaseMessagingBackgroundHandler");
    print(message);
    print(message.data.toString());
    print("app_url");
    print(message.data['app_url']);
    await Firebase.initializeApp();
    print('A bg message just showed up :  ${message.messageId}');
  }


  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');


        setState(() {
          _totalNotifications++;
        });

      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

  }

  @override
  void initState() {
    // TODO: implement initState

    _totalNotifications = 0;
    registerNotification();
    checkForInitialMessage();

    print("HomePage->initState");
    super.initState();
    _init();
    _updateFromDb();

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
  void didChangeDependencies() {
    print("HomePage->didChangeDependencies");
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    print("HomePage->didUpdateWidget");
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  void _init()async{
    print("HomePage->_init");
    bool status = await Provider.of<DataProvider>(context,listen: false).getData();
    _updateFromDb();
  }

  void _updateFromDb(){
    print("HomePage->_updateFromDb");

    // _selectAllCategoriesFromDB(); // Loading the diary when the app starts
    // _selectAllRecepiesFromDB();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: _isLoading == true ? null : Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text("စားမယ်/သောက်မယ်",style:TextStyle(fontSize:18))),
      ),
      body:Provider.of<DataProvider>(context,listen: true).lDBcategories.length == 0 ? Padding(
        padding: const EdgeInsets.all(150),
        child: Center(
          child: LoadingIndicator(
            indicatorType: Indicator.values[30],
            colors: _kDefaultRainbowColors,
            strokeWidth: 4.0,
            pathBackgroundColor:Colors.black45,
          ),
        ),
      ):
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
            physics: BouncingScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
            children: Provider.of<DataProvider>(context,listen: true).lDBcategories.map(
                    (e) => InkWell(
                      child: Container(
                        height: MediaQuery.of(context).size.height/3,
                        child: Card(
                          shape: roundedRectangle12,
                          child: Stack(
                            children: <Widget>[
                              buildImage(e),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(e.categoryName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                        Text(Provider.of<DataProvider>(context,listen: false).lDBrecepies.where((element) => element.categoryId == e.categoryID).toList().length.toString()+" မျိုး" ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                                      ],
                                    ),
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectedCategoryPage( categoryID:e.categoryID,categoryName:e.categoryName,recepieDataModel: Provider.of<DataProvider>(context,listen: false).lDBrecepies)));
                      },
                    )).toList()
        ),
      )
    );
  }

  Widget buildImage(LocalCategory food) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12),bottom: Radius.circular(12)),
      child: CachedNetworkImage(
        imageUrl: food.categoryImgUrl,
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
    );
  }

  // Widget buildTitle(DataModel food) {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 8, right: 8),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text(
  //           food.categoryName,
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //           style: titleStyle,
  //         ),
  //         Text(
  //           food.categoryName,
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //           style: infoStyle,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget buildRating(DataModel food) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 4, right: 8),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         RatingBar(
  //           initialRating: 5.0,
  //           direction: Axis.horizontal,
  //           itemCount: 5,
  //           itemSize: 14,
  //           unratedColor: Colors.black,
  //           itemPadding: EdgeInsets.only(right: 4.0),
  //           ignoreGestures: true,
  //           itemBuilder: (context, index) => Icon(Icons.star, color: mainColor),
  //           onRatingUpdate: (rating) {},
  //         ),
  //         Text('5'),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget buildPriceInfo() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         Text(
  //           '\$ ${100}',
  //           style: titleStyle,
  //         ),
  //         Card(
  //           margin: EdgeInsets.only(right: 0),
  //           shape: roundedRectangle4,
  //           color: mainColor,
  //           child: InkWell(
  //             onTap: (){},
  //             splashColor: Colors.white70,
  //             customBorder: roundedRectangle4,
  //             child: Icon(Icons.add),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
