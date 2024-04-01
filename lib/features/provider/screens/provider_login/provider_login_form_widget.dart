import 'package:mealify_provider/constants/sizes.dart';
import 'package:mealify_provider/constants/text_strings.dart';
import 'package:mealify_provider/features/provider/controllers/provider_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WLoginForm extends StatelessWidget {
  const WLoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WLoginController());
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: myFormHeight - 10),
        child: Obx(()=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: myEmail,
                    hintText: myEmail,
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: myFormHeight - 20),
              TextFormField(
                controller: controller.password,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: myPassword,
                  hintText: myPassword,
                  border: OutlineInputBorder(),
                  // suffixIcon: IconButton(
                  //   onPressed: null,
                  //   icon: Icon(Icons.remove_red_eye_sharp),
                  // ),
                ),
              ),
              const SizedBox(height: myFormHeight - 10),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //       onPressed: () {
              //         // WForgetPasswordScreen.buildShowModalBottomSheet(context);
              //       },
              //       child: const Text(myForgetPassword)),
              // ),
              SizedBox(
                width: double.infinity,
                child: controller.isLoading.value ? Center(child: SizedBox(width:35.0,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red)))) :ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      WLoginController.instance.loginProvider(
                          controller.email.text.trim(),
                          controller.password.text.trim());
                    }
                  },
                  child: Text(myLogin.toUpperCase()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
