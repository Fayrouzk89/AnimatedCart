import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/shared/design/SizeConfig.dart';


class CustomAppBar  extends StatelessWidget implements PreferredSizeWidget {
  final double rating;

  CustomAppBar(this.rating);





  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig().getScreenPropotionWidth(20)),
        child: Row(
          children: [
            SizedBox(
              height: SizeConfig().getScreenPropotionWidth(40),
              width: SizeConfig().getScreenPropotionWidth(40),
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: RatingBar.builder(
                initialRating: rating!,
                allowHalfRating: false,
                itemCount: rating!.toInt(),
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
              )
            )
          ],
        ),
      ),
    );
  }
}
