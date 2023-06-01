import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sar_mal_flutter/provider/data_provider.dart';
import 'package:sar_mal_flutter/view/pages/home_page.dart';
import 'package:provider/provider.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
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

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  try{

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  catch(exp){
    print("firebase init exp");
    print(exp);
  }

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DataProvider()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:HomePage(),
      ),
    )
  );
}
