import 'package:mealify_provider/constants/colors.dart';
import 'package:mealify_provider/constants/image_strings.dart';
import 'package:mealify_provider/features/provider/controllers/provider_products_controller.dart';
import 'package:mealify_provider/features/provider/screens/provider_home/provider_appbar_widget.dart';
import 'package:mealify_provider/features/provider/screens/provider_products/provider_add_product.dart';
import 'package:mealify_provider/features/provider/screens/provider_products/provider_edit_product.dart';
import 'package:mealify_provider/features/provider/screens/provider_products/provider_product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProviderProductsScreen extends StatelessWidget {
  const ProviderProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    const popupMenuTitles = ["Featured", "Edit", "Remove"];
    const popupMenuIcons = [Icons.featured_play_list, Icons.edit, Icons.delete];
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            await controller.getCategories();
            await controller.populateCategoryList();
            Get.to(() => const WAddProduct());
          },
          backgroundColor: purpleColor,
          child: Icon(Icons.add,color: Colors.white,),
        ),
        appBar: WAppBarWidget("Provider Products"),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Meals")
              .where('vendor_id',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!.docs;

              return Column(
                children: [Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              Get.to(() => WProductDetails(data: data[index],));
                            },
                            leading: Image.network(data[index]['p_imgs'][0],
                                height: 100, fit: BoxFit.cover),
                            title: Text("${data[index]['p_name']}",
                                style: const TextStyle(color: darkGrey)),
                            subtitle: Row(
                              children: [
                                Text("${data[index]['p_price']}",
                                    style: const TextStyle(color: lightGrey)),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(data[index]['is_featured'] ? "Featured":"" ,
                                    style: const TextStyle(color: green)),
                              ],
                            ),
                            trailing: VxPopupMenu(
                              arrowSize: 0.0,
                              child: Icon(Icons.more_vert_rounded),
                              menuBuilder: () => Container(
                                width: 200,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: myWhiteColor,
                                ),
                                child: Column(
                                  children: List.generate(
                                      popupMenuTitles.length,
                                      (i) => Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Icon(popupMenuIcons[i],
                                                color: data[index]['featured_id'] == FirebaseAuth.instance.currentUser!.uid && i==0? Colors.green:darkGrey,
                                                ),
                                                SizedBox(width: 10),
                                                Text(data[index]['featured_id'] == FirebaseAuth.instance.currentUser!.uid && i==0?'Remove Featured':
                                                  popupMenuTitles[i],
                                                  style:
                                                      TextStyle(color: darkGrey),
                                                ),
                                              ],
                                            ).onTap(() {
                                              switch(i)
                                              {
                                                case 0:
                                                  if(data[index]['is_featured']==true){
                                                    controller.removeFeatured(data[index].id);
                                                  }
                                                  else{
                                                    controller.addFeatured(data[index].id);
                                                  }
                                                  break;
                                                case 1:
                                                  Get.to(()=> WEditProductScreen(docId:data[index].id));
                                                  break;
                                                case 2:
                                                  controller.removeProduct(data[index].id);
                                                  break;
                                              }
                                            }),
                                          )),
                                ),
                              ),
                              clickType: VxClickType.singleClick,
                            ),
                          ),
                        );
                      }),
                )],
              );
            } else {
              return Center(
                  child: SizedBox(
                      width: 35.0,
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.red))));
            }
          },
        ));
  }
}
