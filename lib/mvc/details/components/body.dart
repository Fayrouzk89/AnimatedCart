import 'package:flutter/material.dart';
import 'package:shop/shared/design/ColorConstants.dart';


import '../../../model/Products.dart';
import '../../../shared/LocalString.dart';
import '../../../shared/design/CommonConstants.dart';
import '../../../shared/design/SizeConfig.dart';
import '../../../shared/widget/CustomRounded.dart';
import '../DetailsController.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Products product;
  final DetailsController detailsController;
   Body({Key? key, required this.product,required this.detailsController}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                detailsController: detailsController,
                pressOnSeeMore: () {},
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig().screenWidth * 0.15,
                  right: SizeConfig().screenWidth * 0.15,
                  //bottom: SizeConfig().getScreenPropotionWidth(40),
                  top: SizeConfig().getScreenPropotionWidth(3),
                ),
                child: Container(
                    child: SizedBox(
                        width: double.infinity,
                        height: SizeConfig().getScreenPropotionHeight(56),
                        child:  CustomRounded(
                            text: LocalString.getStringValue(context, 'add_to_cart') ??
                                "إضافة للسلة",
                            textSize: CommonConstants.textButton,
                            textColor: Colors.white,
                            color: ColorConstants.greenColor,
                            size: Size(SizeConfig().screenWidth * 0.8,
                                CommonConstants.roundedHeight),
                            pressed: () {
                            detailsController.addproductToOrder(product,context);
                            })
                    )
                ),
              ),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ],
    );
  }
}
