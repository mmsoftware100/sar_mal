import 'package:flutter/material.dart';

import '../../model/data_model.dart';
import '../widgets/trending_item.dart';

class SelectedCategoryPage extends StatefulWidget {
  DataModel dataModel;
  SelectedCategoryPage({Key? key,required this.dataModel}) : super(key: key);

  @override
  State<SelectedCategoryPage> createState() => _SelectedCategoryPageState();
}

class _SelectedCategoryPageState extends State<SelectedCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.dataModel.categoryName),
      ),
      body: ListView(
        children: widget.dataModel.categoryData.map((e) {
          return TrendingItem(img: e.imgUrl,title: e.title,address: e.description,rating: "5",);
        }).toList(),
      ),
    );
  }
}
