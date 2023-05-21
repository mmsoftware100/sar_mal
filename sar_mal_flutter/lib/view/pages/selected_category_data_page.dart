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
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.categoryName),
      ),
      body: ListView(
        children: widget.recepieDataModel.map((e) {
          return InkWell(
              child: e.categoryId == widget.categoryID ? TrendingItem(img: e.imgUrl,title: e.title,address: e.description,rating: "5",) : null,
            onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(localRecepie: e)));
            },
          );
        }).toList(),
      ),
    );
  }
}
