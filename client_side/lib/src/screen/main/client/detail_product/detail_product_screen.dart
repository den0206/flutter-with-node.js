import 'package:client_side/src/model/product.dart';
import 'package:client_side/src/screen/main/client/detail_product/detail_product_controller.dart';
import 'package:client_side/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProductController>(
      init: DetailProductController(product),
      builder: (controller) {
        return Column(
          children: [
            _imageSliderShow(context),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              child: Text(
                product.name,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      controller.editCount(true);
                    },
                  ),
                  Obx(() => Text(
                        "${controller.orderCount.value}",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      )),
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      controller.editCount(false);
                    },
                  ),
                  Spacer(),
                  Container(
                    child: Text("${product.price} \$",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/delivery.png",
                    height: 17,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    "Sample Text",
                    style: TextStyle(color: Colors.blueAccent),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: MyColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: Stack(
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        "Order",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/bag.png",
                      height: 17,
                    ),
                  ],
                ),
                onPressed: () {
                  controller.addCart();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _imageSliderShow(BuildContext context) {
    return Stack(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: 400,
          initialPage: 0,
          indicatorColor: MyColors.primary,
          indicatorBackgroundColor: Colors.grey,
          children: [
            Image.asset(
              "assets/images/burger1.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/images/burger2.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/images/pizza2.png",
              fit: BoxFit.cover,
            ),
          ],
          onPageChanged: (value) {
            print('Page changed: $value');
          },
          autoPlayInterval: 3000,
          isLoop: true,
        ),
        Positioned(
          top: 5,
          left: 5,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: MyColors.primary,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        )
      ],
    );
  }
}
