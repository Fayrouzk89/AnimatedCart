import 'package:flutter/material.dart';
import 'package:shop/model/Products.dart';

import '../../../model/Comments.dart';
import '../../../shared/design/Avatar.dart';
import '../../../shared/design/PrimaryText.dart';
import '../DetailsController.dart';
import 'comments.dart';
import 'custom_app_bar.dart';

class AllCommentScreen extends StatefulWidget {
  final  Products products;
  final DetailsController detailsController;
   AllCommentScreen({Key? key, required this.products, required this.detailsController}) : super(key: key);
  @override
  State<AllCommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<AllCommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(widget.products.rate!),
      body:Container(child:  CommentScreen(commentsText:widget.products.commentsText, detailsController:widget.detailsController,),)

    );
  }


}