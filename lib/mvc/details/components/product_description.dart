import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shop/mvc/details/components/all_comments.dart';
import 'package:shop/shared/design/ColorConstants.dart';
import 'package:shop/shared/design/SizeConfig.dart';

import '../../../model/Comments.dart';
import '../../../model/Products.dart';
import '../../../shared/AppFont.dart';
import '../../../shared/LocalString.dart';
import '../../../shared/design/CommonConstants.dart';
import '../DetailsController.dart';
import 'comments.dart';
class ProductDescription extends StatelessWidget {


  final Products product;
  final GestureTapCallback pressOnSeeMore;
  final DetailsController detailsController;
   ProductDescription({Key? key, required this.product, required this.pressOnSeeMore, required this.detailsController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal:  SizeConfig().getScreenPropotionWidth(20)),
          child: Text(
            product.title!,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(height: 10,),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all( SizeConfig().getScreenPropotionWidth(15)),
            width:  SizeConfig().getScreenPropotionWidth(64),
            decoration: BoxDecoration(
              color:
              (true) ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "images/Heart.svg",
              color:
              (product.id==-1) ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
              height:  SizeConfig().getScreenPropotionWidth(16),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left:  SizeConfig().getScreenPropotionWidth(5),
            right:  SizeConfig().getScreenPropotionWidth(5),
          ),
          child: Text(
            product!.description!,
            textAlign: TextAlign.start,

          ),
        ),
        buildRatingWidget(context),
        (product.commentsText!=null && product.commentsText!.length>0)?
         buildComments(context) :Container(child: Text(''),),


        /*
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig().getScreenPropotionWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: ColorConstants.kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color:ColorConstants. kPrimaryColor,
                ),
              ],
            ),
          ),
        )

         */
      ],
    );
  }
  Widget buildComments(BuildContext context)
  {
   List<Comments>? commentsText=[];
    commentsText.add(product.commentsText![0]);
    // chatElement("", context, widget.commentsText![index].user!.name!,widget.commentsText![index].content! ,widget.commentsText![index].createdAt!);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2,right: 2),
          child: Text(
          (LocalString.getStringValue(
                context, 'comments')!+" ("+product.commentsText!.length.toString()+")" )??
                "التعليقات" ,
            textAlign: TextAlign.start,
            style: AppFont.bold.copyWith(
                color: Colors.black,
                fontSize: CommonConstants.header1Text),
          ),
        ),
        CommentScreen(commentsText:commentsText, detailsController: detailsController,),
        buildCommentsWidget(context)

      ],
    );
  }
  Widget buildCommentsWidget(BuildContext context)
  {
   return Container(
      // alignment: AlignmentDirectional.topEnd,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                addCommnent(context);
              },
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline,
                      size: 40,
                      color: ColorConstants.greenColor),
                  Text(
                    LocalString.getStringValue(
                        context, 'add_comment') ??
                        "أضف تعليق",
                    textAlign: TextAlign.center,
                    style: AppFont.bold.copyWith(
                        color: Colors.black,
                        fontSize: CommonConstants.size20),
                  ),
                ],
              ),
            ),
            (product!.commentsText != null &&
                product!.commentsText!.length > 2)
                ? GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AllCommentScreen(products: product, detailsController: detailsController,);
                  },
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    LocalString.getStringValue(
                        context, 'view_more') ??
                        "شاهد المزيد",
                    textAlign: TextAlign.center,
                    style: AppFont.bold.copyWith(
                        color: Colors.black,
                        fontSize: CommonConstants.size20),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                ],
              ),
            )
                : Text(''),
          ],
        ));
  }
  Widget buildRatingWidget(BuildContext context)
  {
    return Container(
      // alignment: AlignmentDirectional.topEnd,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                addRating(context);
              },
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline,
                      size: 40,
                      color: ColorConstants.greenColor),
                  Text(
                    LocalString.getStringValue(
                        context, 'add_rating') ??
                        "أضف تقييم",
                    textAlign: TextAlign.center,
                    style: AppFont.bold.copyWith(
                        color: Colors.black,
                        fontSize: CommonConstants.size20),
                  ),
                ],
              ),
            ),
            (product!.rate != null &&
                product!.rate! > 0)
                ? GestureDetector(
              onTap: () {

              },
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: RatingBar.builder(
                    initialRating: product!.rate!,
                    allowHalfRating: false,
                    itemCount: product!.rate!.toInt(),
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
              ),
            )
                : Text(''),
          ],
        ));
  }
  BuildContext? dialogContext;
  addCommnent(BuildContext context) {
    final TextEditingController _Textcontroller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return Dialog(
            elevation: 0,
            backgroundColor: ColorConstants.whiteBack,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocalString.getStringValue(context, 'add_comment') ??
                          "إضافة تعليق",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _Textcontroller,
                      minLines: 6,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: LocalString.getStringValue(
                              context, 'write_text_here') ??
                              "اكتب نصاً هنا",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                                textStyle: MaterialStateProperty.all(TextStyle(
                                    fontSize: 25,
                                    color: ColorConstants.greenColor))),
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (_Textcontroller.text != null &&
                                  _Textcontroller.text != "") {
                               detailsController.addComment(product, _Textcontroller.text);
                              }
                            },
                            child: Text(
                              "📝",
                              style: TextStyle(color: Colors.green),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                                textStyle: MaterialStateProperty.all(TextStyle(
                                    fontSize: 25,
                                    color: ColorConstants.white))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("❌")),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
  addRating(BuildContext context)
  {
    final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        LocalString.getStringValue(
            context, 'rating_product') ??
            "تقييم المنتج",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        LocalString.getStringValue(
            context, 'confirm_rating_hint') ??
            "تأكيد",

        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: Image.asset('images/logo.png',width: 100,height: 100,),
      submitButtonText:  LocalString.getStringValue(
          context, 'confirm_rating') ??
          "تأكيد",
      commentHint: 'Set your custom comment hint',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
        _rateAndReviewApp(response.rating);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }
  _rateAndReviewApp(double rate)
  {
    detailsController.addRate(product,rate);
  }
}

