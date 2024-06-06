import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shop/api/response/OrderResponse.dart';
import 'package:shop/model/Products.dart';
import 'package:shop/mvc/home/HomeController.dart';
import 'package:shop/shared/design/ColorConstants.dart';

import '../../shared/LocalString.dart';


class OrderCard extends StatelessWidget {
  final HomeController cartController;
  final Order order;

  const OrderCard({Key? key, required this.cartController, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Dismissible(
      key: ValueKey(order.product!.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),

      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(LocalString.getStringValue(context, 'are_you_sure') ?? "كار اونلاين",),
            content: Text(LocalString.getStringValue(context, 'do_u_want') ?? "كار اونلاين"),
            actions: <Widget>[
              FlatButton(
                child: Text(LocalString.getStringValue(context, 'No') ?? "كار اونلاين",),
                onPressed: () {
                  // false mean we want not to confirm the dismiss
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text(LocalString.getStringValue(context, 'yes') ?? "كار اونلاين"),
                onPressed: () {
                  // false mean we want to confirm the dismiss
                  Navigator.of(ctx).pop(false);
                  callDeleteOrder();
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {

      },

      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Container(
                height: 75.0,
                width: 75.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(order.product!.image!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              title: Text(order.product!.title!),
              subtitle: Text(order.product!.description!,overflow: TextOverflow.ellipsis,maxLines: 2,),
              trailing: RatingBar.builder(
                initialRating: order.product!.rate!,
                allowHalfRating: false,
                itemCount: order.product!.rate!.toInt(),
                ignoreGestures: true, // this disables the change star rating
                itemSize: 20,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                updateOnDrag: true,
                onRatingUpdate: (rating) {
                  print("rating");
                },
              ),
            ),
            Divider(
              thickness: 0.8,
            ),
          ],
        ),
      ),

    );



    /*
    return Container(
      height: 114,
      padding: EdgeInsets.only(left: 6, top: 10, bottom: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            height: 82,
            width: 82,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: ColorConstants.greyBack),
            child: Center(
              child: Image.network(product.image!),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title!),
              Text(product.description!),
              SizedBox(
                height: 30,
              ),
              Text(product.rate.toString())
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.all(6),
              height: 40,
              decoration: BoxDecoration(
                  color: ColorConstants.greyBack,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Center(
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 24),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );

     */
  }
  callDeleteOrder()async
  {
    await cartController.deleteOrder(order);
  }
}