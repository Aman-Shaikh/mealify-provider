import 'package:mealify_provider/constants/image_strings.dart';
import 'package:mealify_provider/constants/sizes.dart';
import 'package:mealify_provider/constants/text_strings.dart';
import 'package:mealify_provider/features/provider/controllers/provider_signup_controller.dart';
import 'package:mealify_provider/features/provider/screens/provider_login/provider_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WSignUpFooterWidget extends StatelessWidget {
  const WSignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        // const SizedBox(height: myFormHeight - 20),
        // SizedBox(
        //   width: double.infinity,
        //   child: OutlinedButton.icon(
        //     onPressed: () {
        //       WSignUpController.instance.registerProviderWithGoogle();
        //     },
        //     icon: const Image(
        //       image: AssetImage(myGoogleLogo),
        //       width: 20.0,
        //     ),
        //     label: Text(mySignInWithGoogle.toUpperCase()),
        //   ),
        //
        // ),
        const SizedBox(height: myFormHeight - 20),
        TextButton(
          onPressed: () {
            Get.offAll(const WLoginScreen());
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: myAlreadyHaveAnAccount,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(text: myLogin.toUpperCase())
          ])),
        )
      ],
    );
  }
}
