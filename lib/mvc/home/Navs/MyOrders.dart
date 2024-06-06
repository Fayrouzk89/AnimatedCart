import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/LocalString.dart';
import '../../../shared/design/ColorConstants.dart';
import '../../../shared/widget/CustomEmptyWidget.dart';
import '../../../shared/widget/RoundedIconButton.dart';
import '../HomeController.dart';
import '../OrderCard.dart';
import '../ProductCard.dart';

class MyOrders extends StatefulWidget {
  final HomeController controller;
  MyOrders({Key? key, required this.controller}) : super(key: key);

  @override
  _MainScreenState createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MyOrders> {
  @override
  void initState() {
    super.initState();
    widget.controller.callMyOrders();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [

        Container(
          color: Colors.grey[100],
          child: Container(
            //    physics: BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [

                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          LocalString.getStringValue(context, 'my_orders') ??
                              "طلباتي",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                        ),



                      ],
                    ),
                  ),
                  Obx(
                        () =>buildProductBody(),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget buildProductBody() {
    return (widget.controller!.ProductsOrder!=null && widget.controller!.ProductsOrder.value!=null && widget.controller!.ProductsOrder.value!.data!.length>0)?
    Container(
      // height: 300,
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),

          scrollDirection: Axis.vertical,
          itemCount:widget.controller!.ProductsOrder.value!.data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:1,
            mainAxisSpacing:3,
            mainAxisExtent: 100

          ), itemBuilder: (BuildContext context, int index) {
          return OrderCard(
            order: widget.controller!.ProductsOrder.value!.data![index], cartController: widget.controller,
          );
        },
        )
      
    ):
    (widget.controller!.ProductsOrder!=null && widget.controller!.ProductsOrder.value!=null && widget.controller!.ProductsOrder.value!.data!.length==0)?
    EmptyWidgetCustom():
    ShimmerWidget();

  }
  Widget EmptyWidgetCustom()
  {
    return CustomEmptyWidget(title: LocalString.getStringValue(
        context, 'orders_list') ??
        "قائمة الطلبيات", subtitle: LocalString.getStringValue(
        context, 'no_data_found') ??
        "لا يوجد منتجات", packageImage: PackageImage.Image_2);
  }
  Widget ShimmerWidget()
  {
    return Container();
  }
}