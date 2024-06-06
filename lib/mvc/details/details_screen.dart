import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/Products.dart';
import 'DetailsController.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatefulWidget {
  final Products product;
  final DetailsController detailsController;
  const DetailsScreen({Key? key, required this.product,required this.detailsController}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callMethod();

  }
  callMethod()async
  {
      widget.detailsController!.callMethods();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
    //  appBar: CustomAppBar(widget.product.rate!),
      body:Obx(
            () =>buildProductBody(),
      ),
          /*
      Center(
        child: Obx(
              () =>buildProductBody(),
        ),
      ),

           */

    );
  }
  Widget buildProductBody() {
    return (widget.detailsController!.Product_details!=null && widget.detailsController!.Product_details.value!=null)?
    Body(product: widget.detailsController!.Product_details.value!, detailsController: widget.detailsController,):
    ShimmerWidget();
  }
  Widget ShimmerWidget()
  {
    return Container(child: Text(""),);
  }
}


