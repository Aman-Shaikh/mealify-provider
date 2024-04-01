import 'package:mealify_provider/constants/sizes.dart';
import 'package:mealify_provider/constants/text_strings.dart';
import 'package:mealify_provider/features/provider/controllers/provider_signup_controller.dart';
import 'package:mealify_provider/features/provider/models/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WSignUpFormWidget extends StatelessWidget {
  const WSignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WSignUpController());
    final _formKey = GlobalKey<FormState>();



    return Container(
      padding: const EdgeInsets.symmetric(vertical: myFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Obx(()=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.fullName,
                decoration: const InputDecoration(
                    label: Text(myFullName),
                    prefixIcon: Icon(Icons.person_outline_rounded)),
              ),
              const SizedBox(height: myFormHeight - 20),
              TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                    label: Text(myEmail), prefixIcon: Icon(Icons.email_outlined)),
              ),
              // const SizedBox(height: myFormHeight - 20),
              // TextFormField(
              //   controller: controller.phoneNo,
              //   decoration: const InputDecoration(
              //       label: Text(myPhoneNo), prefixIcon: Icon(Icons.numbers)),
              // ),
              const SizedBox(height: myFormHeight - 20),
              TextFormField(
                controller: controller.password,
                decoration: const InputDecoration(
                    label: Text(myPassword), prefixIcon: Icon(Icons.fingerprint)),
              ),
              const SizedBox(height: myFormHeight - 10),
              SizedBox(
                width: double.infinity,
                child: controller.isLoading.value ? Center(child: SizedBox(width:35.0,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red)))) : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //for email verifacation
                      // SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

                      //for phone verifacation
                      // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                      // Get.to(()=> const OTPScreen());

                      // to add user in database and perform signup authentication after that
                      // final user = UserModel(email: controller.email.text.trim(), password: controller.password.text.trim(), fullName: controller.fullName.text.trim(), phoneNo: controller.phoneNo.text.trim());
                      // SignUpController.instance.createUser(user);


                      final provider = ProviderModel(
                          email: controller.email.text.trim(),
                          password: controller.password.text.trim(),
                          fullName: controller.fullName.text.trim());
                      WSignUpController.instance.registerProvider(provider);
                    }
                  },
                  child: Text(mySignup.toUpperCase()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
