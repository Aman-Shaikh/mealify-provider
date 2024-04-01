import 'package:mealify_provider/constants/image_strings.dart';
import 'package:mealify_provider/constants/sizes.dart';
import 'package:mealify_provider/constants/text_strings.dart';
import 'package:mealify_provider/features/provider/screens/provider_singup/provider_form_header_widget.dart';
import 'package:mealify_provider/features/provider/screens/provider_singup/provider_signup_footer_widget.dart';
import 'package:mealify_provider/features/provider/screens/provider_singup/provider_signup_form_widget.dart';
import 'package:flutter/material.dart';

class WSignUpScreen extends StatelessWidget {
  const WSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(myDefaultSize),
            child: Column(
              children: const [
                WFormHeaderWidget(
                  image: servedLogoWithPhone,
                  title: mySignUpTitle,
                  subTitle: mySignUpSubTitle,
                  imageHeight: 0.15,
                ),
                WSignUpFormWidget(),
                WSignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
