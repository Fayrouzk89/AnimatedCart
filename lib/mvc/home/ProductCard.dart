import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/mvc/details/DetailsController.dart';
import 'package:shop/shared/design/ColorConstants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../globals.dart' as globals;
import '../../model/Products.dart';
import '../../shared/design/SizeConfig.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../details/details_screen.dart';
class ProductCard extends StatelessWidget {
  final Products? product;

  //final Function? onTap;
  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    /*
    return  Container(
      width: SizeConfig().getScreenPropotionWidth(298),
      height: SizeConfig().getScreenPropotionHeight(300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 19,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              product!.title!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstants.kPrimaryColor,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    product!.description!,
                    style: TextStyle(
                      color: ColorConstants.lightGray,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Hero(
                      tag:  product!.id!,
                      child: Image.asset(
                        product!.image!,
                        width: SizeConfig().getScreenPropotionWidth(100),
                        height: SizeConfig().getScreenPropotionHeight(170),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ProductCardBottom(
              product: product!,
            ),
          )
        ],
      ),


    );

     */


    return Container(
      margin: EdgeInsets.only(left: 8,right: 8),
      child: GestureDetector(
        onTap: () {
          openDetails(product, context);
        },
        child:  Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),

              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.kPrimaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text(
                                product!.title!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),

                        Container(
                          height: 100,
                          child: Center(
                            child: Image.network(
                              product!.image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),



                        SizedBox(
                          height: 8,
                        ),

                      ],
                    ),
                  ),


                  ProductCardBottom(
                    product: product!,
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );


  }

  void openDetails(Products? product, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return DetailsScreen(
         detailsController: DetailsController(product!),product: product!,
        );
      },
    ));

  }


}
class ProductCardBottom extends StatelessWidget {
  const ProductCardBottom({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: ColorConstants.kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$${product.comments}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          RatingBar.builder(
            initialRating: product!.rate!,
            allowHalfRating: false,
            itemCount: product.rate!.toInt(),
            ignoreGestures: true, // this disables the change star rating
            itemSize: 20,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.white,
            ),
            onRatingUpdate: (rating) {},
          )
        ],
      ),
    );
  }
}