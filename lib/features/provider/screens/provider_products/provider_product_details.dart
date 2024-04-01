import 'package:mealify_provider/constants/colors.dart';
import 'package:mealify_provider/constants/image_strings.dart';
import 'package:mealify_provider/features/provider/screens/provider_home/provider_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class WProductDetails extends StatelessWidget {
  final dynamic data;
  const WProductDetails({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WAppBarWidget("Provider Product Details"),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 350,
                itemCount: data['p_imgs'].length,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemBuilder: (context, index) {
                  return Image.network(
                    data['p_imgs'][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data['p_name']}",
                      style: TextStyle(
                          color: lightGrey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("${data['p_category']}",
                            style: TextStyle(
                                color: lightGrey,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("${data['p_subcategory']}",
                            style: TextStyle(color: lightGrey, fontSize: 16.0)),
                      ],
                    ),
                    SizedBox(height: 10),

                    //rating
                    VxRating(
                        isSelectable: false,
                        value: double.parse("${data['p_rating']}"),
                        onRatingUpdate: (value) {},
                        normalColor: lightGrey,
                        selectionColor: golden,
                        count: 5,
                        maxRating: 5,
                        size: 25),
                    SizedBox(height: 10),
                    Text("${data['p_price']}", style: TextStyle(color: red, fontSize: 18.0)),
                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(children: [
                              //   SizedBox(
                              //     width: 100,
                              //     child: Text("Color",
                              //         style: TextStyle(
                              //             color: lightGrey,
                              //             fontWeight: FontWeight.bold)),
                              //   ),
                              //   Row(
                              //     children: List.generate(
                              //       data['p_colors'].length,
                              //       (index) => VxBox()
                              //           .size(40, 40)
                              //           .roundedFull
                              //           .color(Color(data['p_colors'][index]).withOpacity(1.0))
                              //           .margin(const EdgeInsets.symmetric(
                              //               horizontal: 4))
                              //           .make()
                              //           .onTap(() {}),
                              //     ),
                              //   ),
                              // ]),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 100,
                                      child: Text("Quantity",
                                          style: TextStyle(
                                              color: lightGrey,
                                              fontWeight: FontWeight.bold))),
                                  SizedBox(height: 10),
                                  Text("${data['p_quantity']} items",
                                      style: TextStyle(color: lightGrey))
                                ],
                              ),
                              const Divider(),
                              SizedBox(height: 20),
                              Text("Description",
                                  style: TextStyle(
                                      color: lightGrey,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text("${data['p_desc']}",
                                  style: TextStyle(color: lightGrey)),
                            ]),
                      ),
                    ),
                  ]),
            ),
          ]),
        ));
  }
}
