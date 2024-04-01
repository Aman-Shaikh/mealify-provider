import 'package:mealify_provider/constants/colors.dart';
import 'package:mealify_provider/features/provider/controllers/provider_orders_controller.dart';
import 'package:mealify_provider/features/provider/screens/provider_home/provider_appbar_widget.dart';
import 'package:mealify_provider/features/provider/screens/provider_orders/provider_order_place.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class WOrderDetails extends StatefulWidget {
  final dynamic data;

  const WOrderDetails({Key? key, this.data}) : super(key: key);

  @override
  State<WOrderDetails> createState() => _WOrderDetailsState();
}

class _WOrderDetailsState extends State<WOrderDetails> {
  var controller = Get.put(OrdersController());

  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenWidth = mediaQuery.size.width;

    return Obx(
      () => Scaffold(
        appBar: WAppBarWidget("Provider Order Details"),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: screenWidth,
            child: ElevatedButton(
              onPressed: () {
                controller.confirmed(true);
                controller.changeStatus(
                    title: "order_confirmed",
                    status: true,
                    docId: widget.data.id);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))),
              child: const Text(
                "Confirm Order",
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // -- order delivery status section
                Visibility(
                  visible: controller.confirmed.value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: myWhiteColor,
                          ),
                        ],
                        border: Border.all(
                          color: textfieldGrey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order Status:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightGrey,
                                  fontSize: 16.0)),
                          SwitchListTile(
                            value: true,
                            onChanged: (value) {},
                            title: Text(
                              "Placed",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightGrey),
                            ),
                            activeColor: green,
                          ),
                          SwitchListTile(
                            value: controller.confirmed.value,
                            onChanged: (value) {
                              controller.confirmed.value = value;
                            },
                            title: Text(
                              "Confirmed",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightGrey),
                            ),
                            activeColor: green,
                          ),
                          SwitchListTile(
                            value: controller.onDelivery.value,
                            onChanged: (value) {
                              controller.onDelivery.value = value;
                              controller.changeStatus(
                                  title: "order_on_delivery",
                                  status: value,
                                  docId: widget.data.id);
                            },
                            title: Text(
                              "on Delivery",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightGrey),
                            ),
                            activeColor: green,
                          ),
                          SwitchListTile(
                            value: controller.delivered.value,
                            onChanged: (value) {
                              controller.delivered.value = value;
                              controller.changeStatus(
                                  title: "order_delivered",
                                  status: value,
                                  docId: widget.data.id);
                            },
                            title: Text(
                              "Delivered",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightGrey),
                            ),
                            activeColor: green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // -- order details section
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: myWhiteColor,
                      ),
                    ],
                    border: Border.all(
                      color: textfieldGrey,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      WOrderPlaceDetails(
                        title1: "Order Code",
                        title2: "Shipping Method",
                        d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}",
                      ),
                      WOrderPlaceDetails(
                        title1: "Order Date",
                        title2: "Payment Method",
                        d1: intl.DateFormat('d/M/y')
                            .format((widget.data['order_date'].toDate())),
                        d2: "${widget.data['payment_method']}",
                      ),
                      WOrderPlaceDetails(
                        title1: "Payment Status",
                        title2: "Delivery Status",
                        d1: "Unpaid",
                        d2: "Order Placed",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // "Shipping Address".text.fontFomily(semibold).moke)
                                Text(
                                  "Shipping Address",
                                  style: TextStyle(
                                      color: purpleColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("${widget.data['order_by_name']}"),
                                Text("${widget.data['order_by_email']}"),
                                Text("${widget.data['order_by_address']}"),
                                Text("${widget.data['order_by_city']}"),
                                Text("${widget.data['order_by_state']}"),
                                Text("${widget.data['order_by_phone']}"),
                                Text("${widget.data['order_by_postalcode']}"),
                              ],
                            ),
                            SizedBox(
                              width: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: TextStyle(
                                        color: purpleColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${widget.data['total_amount']}",
                                    style: TextStyle(
                                        color: red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(height: 10),
                Text(
                  "Ordered Products",
                  style: TextStyle(
                      color: lightGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: myWhiteColor,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(bottom: 4),
                  child: ListView(
                    shrinkWrap: true,
                    children: List.generate(controller.orders.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WOrderPlaceDetails(
                            title1: "${controller.orders[index]['title']}",
                            title2: "${controller.orders[index]['tprice']}",
                            d1: "${controller.orders[index]['qty']}",
                            d2: "Refundable",
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 16.0, vertical: 8.0),
                          //   child: Container(
                          //     width: 30,
                          //     height: 20,
                          //     color: Color(controller.orders[index]['color']),
                          //   ),
                          // ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
