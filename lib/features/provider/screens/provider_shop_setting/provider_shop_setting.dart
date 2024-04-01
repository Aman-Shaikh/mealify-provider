import 'package:mealify_provider/constants/colors.dart';
import 'package:mealify_provider/constants/sizes.dart';
import 'package:mealify_provider/features/provider/controllers/provider_shop_setting_controller.dart';
import 'package:mealify_provider/features/provider/screens/provider_home/provider_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WShopSetting extends StatelessWidget {
  const WShopSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShopSettingController());
    return Obx(()=>Scaffold(
        appBar: WAppBarWidget("Provider Shop Setting"),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(myDefaultSize),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.shopNameController,
                        decoration: const InputDecoration(
                            label: Text("Restaurant Name"),
                            prefixIcon: Icon(Icons.store)),
                      ),
                      const SizedBox(height: myFormHeight - 20),
                      TextFormField(
                        controller: controller.shopAddressController,
                        decoration: const InputDecoration(
                            label: Text("Restaurant Address"),
                            prefixIcon: Icon(Icons.location_on_outlined)),
                      ),
                      const SizedBox(height: myFormHeight - 20),
                      TextFormField(
                        controller: controller.shopMobileController,
                        decoration: const InputDecoration(
                            label: Text("Restaurant Mobile"),
                            prefixIcon: Icon(Icons.phone)),
                      ),
                      const SizedBox(height: myFormHeight - 20),
                      TextFormField(
                        controller: controller.shopWebsiteController,
                        decoration: const InputDecoration(
                            label: Text("Restaurant Website"),
                            prefixIcon: Icon(Icons.laptop_chromebook_rounded)),
                      ),
                      const SizedBox(height: myFormHeight - 20),
                      TextFormField(
                        controller: controller.shopDescriptionController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                            label: Text("Restaurant Description"),
                            prefixIcon: Icon(Icons.description)),
                      ),
                      const SizedBox(height: myFormHeight - 10),
                      SizedBox(
                        width: double.infinity,
                        child: controller.isLoading.value ? Center(child: SizedBox(width:35.0,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red)))) : ElevatedButton(
                          onPressed: () async {
                            await controller.updateShop(
                              shopName: controller.shopNameController.text,
                              shopAddress: controller.shopAddressController.text,
                              shopMobile: controller.shopMobileController.text,
                              shopWebsite: controller.shopWebsiteController.text,
                              shopDescription: controller.shopDescriptionController.text
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: myPrimaryColor,
                              shape: const StadiumBorder(),
                              side: BorderSide.none,
                              foregroundColor: Colors.black),
                          child: Text("Save".toUpperCase()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
