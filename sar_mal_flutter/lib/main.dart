import 'package:flutter/material.dart';
import 'package:sar_mal_flutter/provider/data_provider.dart';
import 'package:sar_mal_flutter/view/home_page.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DataProvider()),
        ],
      child: MaterialApp(
        home:HomePage(),
      ),
    )
  );
}


