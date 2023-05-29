import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sar_mal_flutter/view/pages/selected_category_data_page.dart';

import '../../constant/util.dart';
import '../../database_helper/database_helper.dart';
import '../../database_helper/db.dart';
import '../../model/data_model.dart';
import '../../provider/data_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


   List<Color> _kDefaultRainbowColors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];


   // All categories
   List<LocalCategory> _categories = [];

   // All recepies
   List<LocalRecepie> _recepies = [];

   bool _isLoading = true;
   bool _isLoadingRecepies = true;

   // This function is used to fetch all data from the database
   void _selectAllCategoriesFromDB() async {
     final data = await DatabaseHelper.getCategories();
     _categories.clear();
     setState(() {
       // _categories = data;

       for(int i = 0; i < data.length; i++){
         try{
           _categories.add(LocalCategory.fromJson(data[i]));
           print("Hii "+i.toString());
         }
         catch(ex){
           print("Himm");
           // rethrow;
         }
       }
       _isLoading = false;
     });

     _categories.map((e) {
       print(e.categoryID);
     }).toList();
   }

   // This function is used to fetch all data from the database
   void _selectAllRecepiesFromDB() async {
     final dataRecepies = await DatabaseHelper.getRecepies();
     print(dataRecepies);
     _recepies.clear();
     setState(() {

       for(int i = 0; i < dataRecepies.length; i++){
         try{
           _recepies.add(LocalRecepie.fromJson(dataRecepies[i]));
           print("Hii _recepies  "+i.toString());
           print(_recepies);
         }
         catch(ex){
           print("Himm _recepies ");
           // rethrow;
         }
       }
       _isLoadingRecepies = false;
     });



     _recepies.map((e) {
       print("_recepies title "+e.title);
     }).toList();
   }



  @override
  void initState() {
    // TODO: implement initState
    print("HomePage->initState");
    super.initState();
    _init();
    _updateFromDb();
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

    _selectAllCategoriesFromDB(); // Loading the diary when the app starts
    _selectAllRecepiesFromDB();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: _isLoading == true ? null : Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text("စားမယ်/သောက်မယ်",style:TextStyle(fontSize:18))),
      ),
      body:_isLoading == true ? Padding(
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
            crossAxisCount: 2,
            children: _categories.map(
                    (e) => InkWell(
                      child: Container(
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
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectedCategoryPage( categoryID:e.categoryID,categoryName:e.categoryName,recepieDataModel: _recepies)));
                      },
                    )).toList()
        ),
      )
    );
  }

  Widget buildImage(LocalCategory food) {
    return Container(
      height: MediaQuery.of(context).size.width / 2.5,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        // child: Image.network(
        //   food.categoryImgUrl,
        //   fit: BoxFit.cover,
        // ),
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
          placeholder: (context, url) => Padding(
            padding: const EdgeInsets.all(100.0),
            child: Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
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
