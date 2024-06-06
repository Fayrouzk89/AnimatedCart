import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop/globals.dart';
import 'package:shop/mvc/home/Navs/MainScreen.dart';

import '../../shared/AppFont.dart';
import '../../shared/LocalString.dart';
import '../../shared/design/ColorConstants.dart';
import '../../shared/design/SizeConfig.dart';
import '../../shared/widget/RoundedIconButton.dart';
import 'HomeController.dart';
import 'NavigationItem.dart';
import 'Navs/MyOrders.dart';
import 'ProductCard.dart';
class HomeScreen extends StatefulWidget {
  final HomeController controller;
  HomeScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavigationItem> navigationItems = getNavigationItemList();

  NavigationItem? selectedItem;
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedItem = navigationItems[0];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  Future<void> _loadData() async {
    try {
      widget.controller!.callMethods();


    } catch (err) {
      rethrow;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  RefreshIndicator(
      onRefresh: _loadData,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: null,
          leadingWidth: 0,
          brightness: Brightness.light,
          title: Text(
              LocalString.getStringValue(context, 'app_name') ?? "كار اونلاين",
            style: AppFont.bold.copyWith(
                color: ColorConstants.black,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(

                icon: Icon(
                  Icons.exit_to_app,
                  color: ColorConstants.kPrimaryColor,
                  size: 28,
                ), onPressed: () {
                  widget.controller.exitApp();
              },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             getNavScreen()

            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buildNavigationItems(),
          ),
        ),
      ),
    );
  }
  Widget getNavScreen()
  {
   return (selectedItem==navigationItems[1])?
       MyOrders(controller: widget.controller):
       MainScreen(controller: widget.controller);
  }
  List<Widget> buildNavigationItems(){
    List<Widget> list = [];
    for (var navigationItem in navigationItems) {
    list.add(buildNavigationItem(navigationItem));
    }
    return list;
  }
  navigateToPage(NavigationItem item)
  {
    if(selectedItem==navigationItems[0])
      {
        widget.controller.rate=0;
        widget.controller.callMethods();
      }
  }
  Widget buildNavigationItem(NavigationItem item){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item;
          navigateToPage(item);
        });
      },
      child: Container(
        width: 50,
        child: Stack(
          children: <Widget>[

            selectedItem == item
                ? Center(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.kPrimaryColorShadow,
                ),
              ),
            )
                : Container(),

            Center(
              child: Icon(
                item.iconData,
                color: selectedItem == item ? ColorConstants.kPrimaryColor : Colors.grey[400],
                size: 24,
              ),
            )

          ],
        ),
      ),
    );
  }
List<Widget> buildDealers()
{
  List<Widget> list = [];
  return list;
}
  List<Widget> buildDeals(){
    List<Widget> list = [];

    return list;
  }


}