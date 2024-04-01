

import 'package:get/get.dart';

import '../../../repository/authentication_repository/provider_authentication_repository.dart';
import '../screens/provider_home/provider_home_screen.dart';


class WOTPController extends GetxController {
  static WOTPController get instance => Get.find();

  //this function should be called from otp_screen
  void verifyOTP(String otp) async {
    var isVerified = await WAuthenticationRepository.instance.wVerifyOTP(otp);
    isVerified ? Get.offAll(const ProviderHomeScreen()) : Get.back();
  }


}