import 'package:mealify_provider/exceptions/provider_login_email_password_failure.dart';
import 'package:mealify_provider/exceptions/provider_signup_email_password_failure.dart';
import 'package:mealify_provider/features/entry_point/screens/welcome/weolcome_screen.dart';
import 'package:mealify_provider/features/provider/screens/provider_home/provider_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WAuthenticationRepository extends GetxController {
  static WAuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  // Will be load when app launches this func will be called and set the firebaseProvider state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  //
  // /// If we are setting initial screen from here
  // /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? provider) async {
    await Future.delayed(const Duration(milliseconds: 3000));
    provider == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const ProviderHome());
  }

  //FUNC

  Future<void> wPhoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Error", "The provided phone number is not valid.");
        } else {
          Get.snackbar("Error", "Something went wrong. Try again.");
        }
      },
    );
  }

  //this function is called from the otp_controller
  Future<bool> wVerifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<String?> createProviderWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // firebaseProvider.value != null ? Get.offAll(() => const DashboardScreen())
      //     : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = WSignUpWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = WSignUpWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<String?> wLoginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = WLoginWithEmailAndPasswordFailure.fromCode(e.code);
      return ex.message;
    } catch (_) {
      const ex = WLoginWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<void> wLogOut() async => await _auth.signOut();

  //google signin/signup
  Future<String?> wSignInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleProvider =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleProvider!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // signin
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = WLoginWithEmailAndPasswordFailure.fromCode(e.code);
      return ex.message;
    } catch (_) {
      const ex = WLoginWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }
}
