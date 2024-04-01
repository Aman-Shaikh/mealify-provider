import 'package:mealify_provider/constants/sizes.dart';
import 'package:mealify_provider/features/provider/screens/provider_login/provider_login_footer_widget.dart';
import 'package:mealify_provider/features/provider/screens/provider_login/provider_login_form_widget.dart';
import 'package:mealify_provider/features/provider/screens/provider_login/provider_login_header_widget.dart';
import 'package:flutter/material.dart';

class WLoginScreen extends StatelessWidget {
  const WLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get the size in LoginHeaderWidget()
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(myDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                WLoginHeaderWidget(),
                WLoginForm(),
                WLoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
