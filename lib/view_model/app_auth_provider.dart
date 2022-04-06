import 'package:blindside_code_challenge/model/app_user.dart';
import 'package:blindside_code_challenge/view_model/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../routes/app_routs.dart';

class AppAuthProvider extends ChangeNotifier {
  UserCredential? userCredential;
  User? currentUser;

  Future<void> sendOTPcode({required BuildContext context}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber:
          Provider.of<UserProvider>(context, listen: false).mobileNumber!,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        UserCredential result = await _auth.signInWithCredential(credential);

        User? user = result.user;

        if (user != null) {
          Navigator.pushReplacementNamed(context, AppRoutes.all_videos_page);
        } else {
          print("Error");
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (exception) {
        print(exception);
      },
      codeSent: (String verificationId, int? resendToken) async {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //sign in with phone number
  Future<void> signInWithPhoneNumber({required BuildContext context}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber:
          Provider.of<UserProvider>(context, listen: false).mobileNumber!,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {},
      verificationFailed: (exception) {},
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = Provider.of<UserProvider>(context, listen: false).otp!;

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await _auth.signInWithCredential(credential).then((value) {
          AppUser user = AppUser(
              mobileNumber: Provider.of<UserProvider>(context, listen: false)
                  .mobileNumber!);
          Provider.of<UserProvider>(context, listen: false)
              .createNewUserData(user: user)
              .then((value) => Navigator.pushReplacementNamed(
                  context, AppRoutes.all_videos_page));
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
