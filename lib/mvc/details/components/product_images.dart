import 'package:flutter/material.dart';
import 'package:shop/shared/design/ColorConstants.dart';
import 'package:shop/shared/design/SizeConfig.dart';

import '../../../model/Products.dart';

class ProductImages extends StatefulWidget {


  final Products? product;

  const ProductImages({Key? key, this.product}) : super(key: key);

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: SizeConfig().screenWidth,
              height: SizeConfig().getScreenPropotionHeight(250),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(widget.product!.image!,fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 10,),
            // SizedBox(height: getProportionateScreenWidth(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(1,
                    (index) => buildSmallProductPreview(index)),
              ],
            )
          ],
        ),
        Positioned(
          // The Positioned widget is used to position the text inside the Stack widget
          top: 10,
          left: 10,
          child:Padding(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 3),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.cancel,
                  color: ColorConstants.darkGray,
                  size: 35.0,
                ),
              )),
        ),
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 20),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: SizeConfig().getScreenPropotionWidth(48),
        width:  SizeConfig().getScreenPropotionWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: ColorConstants.kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(widget.product!.image!),
      ),
    );
  }
}
