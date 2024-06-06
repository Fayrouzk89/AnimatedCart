import 'package:flutter/material.dart';
import 'package:shop/model/Products.dart';

import '../../../model/Comments.dart';
import '../../../shared/design/Avatar.dart';
import '../../../shared/design/PrimaryText.dart';
import '../DetailsController.dart';

class CommentScreen extends StatefulWidget {
  final  List<Comments>? commentsText;
  final DetailsController detailsController;
   CommentScreen({Key? key, required this.commentsText, required this.detailsController}) : super(key: key);
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.commentsText!.length,
      itemBuilder: (context, index) => chatElement("", context, widget.commentsText![index].user!.name!,widget.commentsText![index].content! ,widget.commentsText![index].createdAt!),
    );
  }

  Widget chatElement(String avatarUrl, BuildContext context, String name, String message, String time) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        child: ListTile(
          onTap: () => {

          },
         leading: Avatar(avatarUrl: avatarUrl),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(text: name),
              PrimaryText(text: getTime(time), color: Colors.grey[400]),
            ],
          ),
          subtitle: PrimaryText(
              text: message,
              color: Colors.grey[600],
            ),
        ),
      ),
    );
  }
  String getTime(String time)
  {
    var date = DateTime.parse(time);
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    return formattedDate;
  }
}