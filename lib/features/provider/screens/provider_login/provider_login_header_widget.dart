import 'package:mealify_provider/constants/image_strings.dart';
import 'package:mealify_provider/constants/text_strings.dart';
import 'package:flutter/material.dart';

class WLoginHeaderWidget extends StatelessWidget {
  const WLoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage(servedLogoWithPhone),
            height: size.height * 0.2),
        Text(myLoginTitle, style: Theme.of(context).textTheme.headline3),
        Text(myLoginSubTitle, style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
